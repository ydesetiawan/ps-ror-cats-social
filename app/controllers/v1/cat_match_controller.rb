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

    private
      def match_params
        params.permit(
          :matchCatId, :userCatId, :message
        )
      end

  end

end
