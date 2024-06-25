# frozen_string_literal: true

module Cats
  class CreateCatService
    def initialize(user, create_cat_params)
      @user = user
      @cat = Cat.new(create_cat_params)
      @cat.user = @user
    end

    def call
      if @cat.valid?
        save_cat
      else
        raise BadRequestException.new(@cat.errors.full_messages.join(", "))
      end
    end

    private
      def save_cat
        if @cat.save
          { message: "success",
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
