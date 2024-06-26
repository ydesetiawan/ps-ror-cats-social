class Cat < ApplicationRecord
  belongs_to :user
  # Enums for race and sex
  RACES = %w[Persian Maine\ Coon Siamese Ragdoll Bengal Sphynx British\ Shorthair Abyssinian Scottish\ Fold Birman].freeze
  SEXES = %w[male female].freeze

  def ageInMonth
    age_in_months
  end

  def ageInMonth=(value)
    self.age_in_months = value
  end

  def imageUrls
    image_urls
  end

  def imageUrls=(value)
    self.image_urls = value
  end

  # Validations
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :race, presence: true, inclusion: { in: RACES }
  validates :sex, presence: true, inclusion: { in: SEXES }
  validates :age_in_months, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 120082 }
  validates :description, presence: true, length: { minimum: 1, maximum: 200 }
  validates :image_urls, presence: true
  validate :validate_image_urls

  def self.update_has_matched(cat_id)
    cat = find_by(id: cat_id)
    raise NotFoundException.new("Cat id is not found") unless cat
    unless cat.update(has_matched: true)
      raise InternalServerErrorException.new(cat.errors.full_messages.join(", "))
    end
  end

  private
    def validate_image_urls
      if image_urls.is_a?(Array) && image_urls.any?
        image_urls.each do |url|
          unless url.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
            errors.add(:image_urls, "must be valid URLs")
          end
        end
      else
        errors.add(:image_urls, "must be an array with at least one item")
      end
    end
end
