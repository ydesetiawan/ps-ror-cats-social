# frozen_string_literal: true

module Cats
  class BaseCatMatchService
    def initialize(user, cat_match_id)
      @user = user
      @cat_match_id = cat_match_id
    end

    private
      def find_cat_match
        @cat_match = CatMatches.find_by(id: @cat_match_id, status: 'pending')
        raise NotFoundException.new("match id is not found")  unless  @cat_match
      end

      def validate_receiver
        raise BadRequestException.new("matchId is no longer valid") if @cat_match.receiver != @user
      end
  end
end

