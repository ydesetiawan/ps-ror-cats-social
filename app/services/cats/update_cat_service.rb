# frozen_string_literal: true

module Cats
  class UpdateCatService
    def initialize(user, cat_id, update_cat_params)
      @user = user
      @update_cat_params = update_cat_params
      @cat_id = cat_id
    end

    def update_cat
      @cat = Cat.find_by(id: @cat_id)
      raise NotFoundException.new("Cat not found") unless @cat

      validate_user_ownership

      # TODO
      # 400 sex is edited when cat is already requested to match
      #
      temp_cat = Cat.new(@update_cat_params)
      temp_cat.user = @user
      if temp_cat.valid?
        save_cat
      else
        raise BadRequestException.new(validate_cat_params.errors.full_messages.join(", "))
      end
    end

    private
      def validate_user_ownership
        raise NotFoundException.new("Cat not found") if @cat.user.id != @user.id
      end
      def save_cat
        if @cat.update(@update_cat_params)
          { message: "update success",
            data: {
              id: @cat.id,
              created_at: @cat.created_at
            }
          }
        else
          raise InternalServerErrorException.new(@cat.errors.full_messages.join(", "))
        end
      end
  end
end