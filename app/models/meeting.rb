class Meeting < ApplicationRecord
  belongs_to :room, optional: true
  validates_presence_of :room_id, :date, :time_start, :time_end, :name
  validates_uniqueness_of :name, scope: [:room_id, :date]
  include ActiveModel::Validations
  validates_with MeetingValidator

  def self.safe_attributes
    [:name, :contract_id, :description, :time_start, :time_end, :color]
  end


  def guess_path
    "/room/#{self.room_id}/meetings/#{self.id}"
  end

  def self.for_month(date)
    where('( date >= :start_date AND date <= :end_date)',
          start_date: date.beginning_of_month,
          end_date: date.end_of_month
    )
  end


end
