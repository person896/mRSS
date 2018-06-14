FROM     drecom/centos-base:latest

RUN cd /
RUN yum update -y
RUN yum install -y epel-release yum-utils
RUN yum-config-manager --enable epel
RUN yum clean all && yum update -y
RUN yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

RUN useradd -ms /bin/bash app
USER app
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
RUN /bin/bash -l -c "\curl -sSL https://get.rvm.io | bash -s stable --ruby"
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.3.3"
RUN rvm install ruby-2.3.6
RUN rvm install ruby-devel-2.3.6
RUN /bin/bash -l -c "rvm use 2.3.6 --default"

RUN yum install -y git

RUN cd /var/www/
RUN git clone https://github.com/MicroHealthLLC/mRSS

RUN cd /var/www/mRSS
RUN gem install rails
RUN gem install bundler
RUN yum install nodejs
RUN bundle install
RUN rails db:setup
RUN rake assets:precompile

RUN cp /var/www/mRSS/nginx.repo

RUN yum install -y nginx

RUN yum install -y pygpgme curl
RUN curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
RUN yum install -y nginx passenger || sudo yum-config-manager --enable cr && sudo yum install -y nginx passenger
RUN echo "passenger_ruby /usr/local/rvm/gems/ruby-2.3.6/wrappers/ruby;" >> /etc/nginx/conf.d/passenger.conf
RUN source /etc/nginx/conf.d/passenger.conf
RUN exec -l $SHELL
RUN service nginx restart


EXPOSE 3000

WORKDIR /var/www/mRSS

