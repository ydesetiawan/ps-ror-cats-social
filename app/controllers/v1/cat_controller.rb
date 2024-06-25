# frozen_string_literal: true
module V1
  class CatController < ApplicationController
    before_action :authenticate_request
    def index
      service = Cats::CatQueryService.new(current_user, params)
      result = service.call
      render json: result
    end
    def create
      service = Cats::CreateCatService.new(current_user, create_cat_params)
      result = service.call
      render json: result
    end
    def update
      service = Cats::UpdateCatService.new(current_user, params[:id], create_cat_params)
      result = service.call
      render json: result
    end

    def destroy
      service = Cats::DeleteCatService.new(current_user, params[:id])
      result = service.call
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