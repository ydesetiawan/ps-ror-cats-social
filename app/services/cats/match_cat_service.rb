# frozen_string_literal: true

module Cats
  class MatchCatService < BaseCatService
    def initialize(user, params)
      @user = user
      @match_cat_id = params[:matchCatId]
      @user_cat_id = params[:userCatId]
      @message = params[:message]
    end

    def call
      find_user_cat
      find_match_cat
      validate_same_owner
      validate_gender
      validate_has_matched
      save
    end

    private
      def find_user_cat
        @cat_id = @user_cat_id
        @user_cat = find_cat_with_identity("UserCatId")
        validate_user_ownership
      end

      def find_match_cat
        @cat_id = @match_cat_id
        @match_cat = find_cat_with_identity("MatchCatId")
      end

      def validate_gender
        raise BadRequestException.new("gender is same") if @user_cat.sex == @match_cat.sex
      end

      def validate_same_owner
        raise BadRequestException.new("MatchCatId and UserCatId are from the same owner") if (@user_cat_id == @match_cat_id) || (@match_cat.user == @user)
      end

      def validate_has_matched
        raise BadRequestException.new("Both matchCatId and userCatId already matched") if @match_cat.has_matched || @user_cat.has_matched
      end
      def save
        @cat_matches = CatMatches.new(issuer: @user, receiver: @match_cat.user, match_cat_id: @match_cat_id, user_cat_id: @user_cat_id, message: @message, status: 'pending')
        if @cat_matches.save
          { message: "successfully send match request" }
        else
          raise InternalServerErrorException.new(@cat_matches.errors.full_messages.join(", "))
        end
      end
  end
end
