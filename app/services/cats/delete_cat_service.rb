# frozen_string_literal: true

module Cats
  class DeleteCatService < BaseCatService
    def delete_cat
      find_cat
      validate_user_ownership
      @cat.destroy if @cat
      { success: "true" }
    end
  end
end
