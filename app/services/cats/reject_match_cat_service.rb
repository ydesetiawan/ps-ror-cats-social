# frozen_string_literal: true

module Cats
  class RejectMatchCatService < BaseCatMatchService
    def initialize(user, cat_match_id)
      super(user, cat_match_id)
    end

    def call
      find_cat_match
      validate_receiver
      reject_match
    end

    private
      def reject_match
        if @cat_match.update(status: 'rejected')
          { message: "successfully reject the cat match request" }
        else
          raise InternalServerErrorException.new("Error when reject request")
        end
      end
  end
end
