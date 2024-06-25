# frozen_string_literal: true

class CatMatches < ApplicationRecord
  belongs_to :issuer, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :message, presence: true, length: { minimum: 1, maximum: 120 }
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }

  enum status: {
    pending: 'pending',
    approved: 'approved',
    rejected: 'rejected'
  }
end
