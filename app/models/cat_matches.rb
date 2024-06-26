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

  def self.find_by_match_cat_id_and_status(match_cat_id, status)
    where(match_cat_id:, status:)
  end

  def self.find_by_user_cat_id_and_status(user_cat_id, status)
    where(user_cat_id:, status:)
  end
end
