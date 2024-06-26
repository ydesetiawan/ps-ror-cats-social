# frozen_string_literal: true

module Cats
  class BaseCatService
    def initialize(user, cat_id)
      @user = user
      @cat_id = cat_id
    end

    private
      def find_cat
        @cat = Cat.find_by(id: @cat_id)
        raise NotFoundException.new("Cat not found") unless @cat
      end

      def find_cat_with_identity(identity)
        @cat = Cat.find_by(id: @cat_id)
        raise NotFoundException.new(identity + " is not found") unless @cat
        @cat
      end

      def validate_user_ownership
        raise NotFoundException.new("User Cat Id is not belong to the user") if @cat.user.id != @user.id
      end
  end
end
