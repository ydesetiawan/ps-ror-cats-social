# frozen_string_literal: true

module Cats
  class CatQueryService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      cats = Cat.all
      cats = cats.where(id: @params[:id]) if @params[:id].present?
      cats = cats.where(race: @params[:race]) if @params[:race].present?
      cats = cats.where(sex: @params[:sex]) if @params[:sex].present?
      cats = filter_by_match(cats, @params[:hasMatched]) if @params[:hasMatched].present?
      cats = filter_by_age(cats, @params[:ageInMonth]) if @params[:ageInMonth].present?
      cats = filter_by_ownership(cats, @params[:owned]) if @params[:owned].present?
      cats = cats.where('name LIKE ?', "%#{@params[:search]}%") if @params[:search].present?

      limit = @params[:limit] || 5
      offset = @params[:offset] || 0
      cats = cats.order(created_at: :desc).limit(limit).offset(offset)

      format_response(cats)
    end

    private
      def filter_by_match(cats, has_matched)
        has_matched == 'true' ? cats.where(has_matched: true) : cats.where(has_matched: false)
      end

      def filter_by_age(cats, age_in_month)
        if age_in_month.include?('>')
          age = age_in_month.delete('>').to_i
          cats.where('age_in_month > ?', age)
        elsif age_in_month.include?('<')
          age = age_in_month.delete('<').to_i
          cats.where('age_in_month < ?', age)
        else
          age = age_in_month.to_i
          cats.where(age_in_month: age)
        end
      end

      def filter_by_ownership(cats, owned)
        if owned == 'true'
          cats.where(user_id: @user.id)
        else
          cats.where.not(user_id: @user.id)
        end
      end

      def format_response(cats)
        { message: "success",
          data: cats.map do |cat|
            {
              id: cat.id,
              name: cat.name,
              race: cat.race,
              sex: cat.sex,
              ageInMonth: cat.age_in_months,
              imageUrls: cat.image_urls, # Assuming Cat has_many :images and Image has a url attribute
              description: cat.description,
              hasMatched: cat.has_matched,
              createdAt: cat.created_at.iso8601
            }
          end
        }
      end
  end
end
