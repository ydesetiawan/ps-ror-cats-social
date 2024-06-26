# frozen_string_literal: true

module Cats
  class DeleteCatService < BaseCatService
    def initialize(user, cat_id)
      super(user, cat_id)
    end
    def call
      find_cat
      validate_user_ownership
      @cat.destroy if @cat
      { success: "true" }
    end
  end
end
