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

      def validate_user_ownership
        raise NotFoundException.new("Cat not found") if @cat.user.id != @user.id
      end
  end
end
