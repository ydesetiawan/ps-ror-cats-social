# frozen_string_literal: true
module Cats
  class DeleteCatService
    def initialize(user, cat_id)
      @user = user
      @cat_id = cat_id
    end
    def delete_cat
      @cat = Cat.find_by(id: @cat_id)
      raise NotFoundException.new("Cat not found") unless @cat

      validate_user_ownership

      @cat.destroy if @cat
      {success: "true"}
    end
  
    private
      def validate_user_ownership
        raise NotFoundException.new("Cat not found") if @cat.user.id != @user.id
      end
    end
end
