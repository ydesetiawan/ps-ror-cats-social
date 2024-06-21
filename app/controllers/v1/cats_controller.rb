# frozen_string_literal: true
module V1
  class CatsController < ApplicationController
    before_action :authenticate_request
    def create_cat
      service = Cats::CreateCatService.new(current_user, create_cat_params)
      result = service.create_cat
      render json: result
    end

    def update_cat
      service = Cats::UpdateCatService.new(current_user, params[:id], create_cat_params)
      result = service.update_cat
      render json: result
    end

    private
      def create_cat_params
        params.permit(
          :name, :race, :sex, :ageInMonth, :description, imageUrls: []
        )
      end
      def update_cat_params
        params.permit(
          :name, :race, :sex, :ageInMonth, :description, imageUrls: []
        )
      end
  end
end