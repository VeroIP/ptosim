class Organization < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 120 }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }

  before_validation :generate_slug_from_name, on: :create

  private

  def generate_slug_from_name
    return if slug.present? || name.blank?

    base = name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
    candidate = base
    n = 2
    while Organization.exists?(slug: candidate)
      candidate = "#{base}-#{n}"
      n += 1
    end
    self.slug = candidate
  end
end
