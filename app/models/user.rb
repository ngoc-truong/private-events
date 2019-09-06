class User < ApplicationRecord
    # We want to access the token but not save it in the database (like the password with "has_secure_password")

    attr_accessor :remember_token 
    before_save { email.downcase! }
    validates :name,        presence: true, 
                            length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,       presence: true, 
                            length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }

    validates :password,    presence: true, 
                            length: { minimum: 6 }

    has_secure_password

    has_many :created_events, foreign_key: :creator_id, class_name: "Event"
    has_many :invitations, foreign_key: :attendee_id
    has_many :attended_events, through: :invitations




    # Returns hash digest/encryption of the given string
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token/string
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions
    def remember 
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest (similar to #authenticate method for passwords)
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
    end

    def forget 
      update_attribute(:remember_digest, nil)
    end
  end