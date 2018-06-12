class Room < ApplicationRecord
  validates_uniqueness_of :name
  validates_presence_of :name

  has_many :meetings, dependent: :destroy

  def to_s
    name
  end

end
