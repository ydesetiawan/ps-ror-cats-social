# frozen_string_literal: true

module V1
  class CatMatchController < ApplicationController
    before_action :authenticate_request
    def index

    end

    def create
      service = Cats::MatchCatService.new(current_user, params)
      result = service.call
      render json: result, status: 201
    end

    def approve
      service = Cats::ApproveMatchCatService.new(current_user, approval_params[:matchId])
      result = service.call
      render json: result
    end

    def reject
      service = Cats::RejectMatchCatService.new(current_user, approval_params[:matchId])
      result = service.call
      render json: result
    end

    def delete
      service = Cats::DeleteMatchCatService.new(current_user, params[:id])
      result = service.call
      render json: result
    end

    private
      def match_params
        params.permit(
          :matchCatId, :userCatId, :message
        )
      end
      def approval_params
        params.permit(
          :matchId
        )
      end
  end

end
