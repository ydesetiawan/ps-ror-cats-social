# frozen_string_literal: true

module Cats
  class DeleteCatService < BaseCatService
    def call
      find_cat
      validate_user_ownership
      @cat.destroy if @cat
      { success: "true" }
    end
  end
end
