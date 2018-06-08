class Meeting < ApplicationRecord
  belongs_to :room, optional: true

  validates_presence_of :room_id, :date, :time_start, :time_end, :name

  validates_uniqueness_of :name, scope: [:room_id, :date]

  validate :check_avaibility

  def self.safe_attributes
    [:name, :contract_id, :description, :time_start, :time_end, :color]
  end

  def check_avaibility
    if Meeting.where(room_id: self.room_id, date: self.date).
        where('(time_start between :date_start and :date_end) or (time_end between :date_start and :date_end)',
              :date_start=> self.time_start + 1.minute, :date_end=> self.time_end - 1.minute).present?
       errors.add(:base, 'Time not available for this room')
    end

  end

  def color
    'bg-color-blue txt-color-white'
  end

  def guess_path
    "/events/#{self.id}"
  end

  def self.for_month(date)
    where('( date >= :start_date AND date <= :end_date)',
          start_date: date.beginning_of_month,
          end_date: date.end_of_month
    )
  end


end
