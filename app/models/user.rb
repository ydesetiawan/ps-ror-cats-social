# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 5, maximum: 100 }

  has_many :cat
end
