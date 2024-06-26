# frozen_string_literal: true

module Cats
  class UpdateCatService < BaseCatService
    def initialize(user, cat_id, update_cat_params)
      super(user, cat_id)
      @update_cat_params = update_cat_params
    end

    def call
      find_cat
      validate_user_ownership
      temp_cat = build_temp_cat(@update_cat_params)
      validate_cat_updated_params(temp_cat)
      validate_sex_change
      save_cat
    end

    private
      def build_temp_cat(params)
        temp_cat = Cat.new(params)
        temp_cat.user = @user
        temp_cat
      end

      def validate_cat_updated_params(temp_cat)
        raise BadRequestException.new(temp_cat.errors.full_messages.join(", ")) unless temp_cat.valid?
      end
      def validate_sex_change
        if sex_change_requested? && @cat.has_matched?
          raise BadRequestException.new("Cannot change sex when the cat has a pending match request")
        end
      end
      def sex_change_requested?
        @update_cat_params.key?(:sex) && @update_cat_params[:sex] != @cat.sex
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
