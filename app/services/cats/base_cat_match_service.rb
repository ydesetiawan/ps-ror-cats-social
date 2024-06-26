# frozen_string_literal: true

module Cats
  class BaseCatMatchService
    def initialize(user, cat_match_id)
      @user = user
      @cat_match_id = cat_match_id
    end

    private
      def find_cat_match
        @cat_match = CatMatches.find_by(id: @cat_match_id)
        raise NotFoundException.new("match id is not found")  unless  @cat_match
        raise BadRequestException.new("matchId is no longer valid") if @cat_match.status != 'pending'
      end

      def validate_receiver
        raise BadRequestException.new("matchId is no longer valid") if @cat_match.receiver != @user
      end

      def validate_issuer
        raise BadRequestException.new("Match can only be deleted by issuer") if @cat_match.issuer != @user
      end
  end
end

