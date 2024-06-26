# frozen_string_literal: true

module Cats
  class ApproveMatchCatService < BaseCatMatchService
    def initialize(user, cat_match_id)
      @user = user
      @cat_match_id = cat_match_id
    end

    def call
      CatMatches.transaction do
        find_cat_match
        validate_receiver
        delete_another_request
        approve
        update_has_match_for_each_cat
      end
      rescue ActiveRecord::RecordInvalid => e
        raise InternalServerErrorException.new(e.message)
    end

    private
      def find_by_another_request
        matches_by_match_cat = CatMatches.find_by_match_cat_id_and_status(@cat_match.match_cat_id, 'pending')
        matches_by_user_cat = CatMatches.find_by_user_cat_id_and_status(@cat_match.user_cat_id, 'pending')
        (matches_by_match_cat + matches_by_user_cat).uniq
      end
      def delete_another_request
        matches = find_by_another_request
        matches_to_delete = matches.reject { |match| match.id == @cat_match.id }
        CatMatches.where(id: matches_to_delete.map(&:id)).delete_all
      end
      def update_has_match_for_each_cat
        Cat.update_has_matched(@cat_match.user_cat_id)
        Cat.update_has_matched(@cat_match.match_cat_id)
        { message: "successfully approve the cat match request" }
      end
      def approve
        unless @cat_match.update(status: 'approved')
          raise InternalServerErrorException.new("Error when approve the cat match request")
        end
      end
  end
end
