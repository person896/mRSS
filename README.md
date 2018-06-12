# update centos

yum update
yum install -y epel-release yum-utils
yum-config-manager --enable epel
yum clean all && sudo yum update -y

# install ruby

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
\curl -sSL https://get.rvm.io | bash -s stable --ruby 

usermod -a -G rvm `whoami'

export PATH="$PATH:$HOME/.rvm/bin"

rvm install ruby-2.3.6
rvm install ruby-devel-2.3.6

bash -l -c "rvm use 2.3.6 --default"

# be sure git is installed
yum install git

# go to /var/www and from there 
cd /var/www/

git clone https://github.com/MicroHealthLLC/mRSS

# go to the cloned directory 
cd /var/www/mRSS 

gem install rails

gem install bundler

yum install sqlite-devel

yum install nodejs

bundle install

rails db:setup 

rake assets:precompile

# Configure Nginx repo for CentOS 7

nano /etc/yum.repos.d/nginx.repo

# then enter this below and save

[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1

yum update

yum install -y nginx

# install passenger phusion

sudo yum install -y pygpgme curl

sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

sudo yum install -y nginx passenger || sudo yum-config-manager --enable cr && sudo yum install -y nginx passenger

# then go edit passenger.conf
nano /etc/nginx/conf.d/passenger.conf

# -where it says passenger_ruby change what you see there to what you see below.  If that doesn't work then do this "which passenger-config" to get the path to put next to passenger_ruby

passenger_ruby /usr/local/rvm/gems/ruby-2.3.6/wrappers/ruby;
--uncomment the line above and the line below that passenger_ruby

# restart nginx
service nginx restart


