class MeetingValidator < ActiveModel::Validator
  def validate(record)
      if Meeting.where(room_id: record.room_id, date: record.date).where.not(id: record.id).
          where('(time_start between :date_start and :date_end) or (time_end between :date_start and :date_end) or (time_start < :date_start AND time_end > :date_end)',
                :date_start=> record.time_start + 1.minute, :date_end=> record.time_end - 1.minute).present?
        record.errors[:base]<< 'Time is not available for this room'
      end

      if record.date < Date.today
        record.errors[:base]<<  'Cannot save meeting from the past'
      end
      if record.time_end < record.time_start
        record.errors[:time_start] <<  'should be before end time'
      end


  end
end