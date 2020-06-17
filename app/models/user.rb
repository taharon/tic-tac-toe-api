# frozen_string_literal: true

# class for User model
class User < ApplicationRecord
  include Authentication
  has_many :games
  validates :email, presence: true
end
