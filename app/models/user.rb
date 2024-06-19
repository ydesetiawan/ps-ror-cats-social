# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
  validates :password, presence: true, length: { minimum: 5, maximum: 100 }

  has_many :cat
end
