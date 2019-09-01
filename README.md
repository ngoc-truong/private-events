# Private events

In this app users can create events, invite other users and attend other events. This app is a practice app in order to create advanced ActiveRecord associations. This project is part of [The Odin Project](https://www.theodinproject.com/lessons/associations), a curriculum to learn full stack web development with ruby and ruby on rails. 

## Modelling
- A user can create events
- An event can be attended by many users

### Users Model
- has_many :hosted_events, foreign_key: :host_id, class-name: "Events"
- has_many :attended_events, through: :invitations
- has_many :invitations, foreign_key: :attendee_id

- username: string (unique)
- password: string (unique)

### Events Model
- belongs_to :host, class_name: "User"
- has_many :attendees, through: :invitations
- has_many :invitations, foreign_key: :attended_event_id

- date: datetime
- location: string
- host_id: integer

### Invitations Model
- belongs_to :attendee, class_name: "User"
- belongs_to :attended_event, class_name: "Post"

- attendee_id: integer
- attended_event_id: integer
- attended: boolean
