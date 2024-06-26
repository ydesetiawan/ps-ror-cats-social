# frozen_string_literal: true

module Cats
  class DeleteMatchCatService < BaseCatMatchService
    def initialize(user, match_id)
      super(user, match_id)
    end
    def call
      find_cat_match
      validate_issuer
      delete_cat_match
    end

    private
      def delete_cat_match
        if @cat_match.destroy
          { message: "successfully remove a cat match request" }
        else
          raise InternalServerErrorException.new(@cat_match.errors.full_messages.join(", "))
        end
      end
  end
end
