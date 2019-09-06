class Event < ApplicationRecord
    scope :previous, -> { where("date < ?", Time.now) }
    scope :upcoming, -> { where("date > ?", Time.now) }
    
    belongs_to  :creator, class_name: "User"
    has_many    :invitations, foreign_key: :attended_event_id
    has_many    :attendees, through: :invitations, source: :attendee
end
