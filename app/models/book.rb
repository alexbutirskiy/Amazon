class Book < ActiveRecord::Base
  BESTSELLERS_COUNT = 5
  BOOKS_PER_PAGE = 9

  has_many :book_authors
  has_many :authors, through: :book_authors
  belongs_to :category

  after_initialize :set_defaults, if: :new_record?

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :in_stock, numericality: { greater_than_or_equal_to: 0 }
  validates :sold, numericality: { greater_than_or_equal_to: 0 }

  scope :in_stock, -> { where('in_stock > 0') }
  scope :out_of_stock, -> { where('in_stock = 0') }
  scope :bestsellers, -> { order(sold: :desc) }

  paginates_per BOOKS_PER_PAGE

  # def self.bestseller(place)

  #   unless (1..bestsellers_max).include?(place)
  #     raise ActiveRecord::RecordNotFound, "Wrong place #{place} given"
  #   end
    
  #   self.order(sold: :desc).offset(place - 1).limit(1).first
  # end

  # def self.bestsellers_max
  #   [ Book.count, BESTSELLERS_COUNT ].min
  # end

  private

  def set_defaults
    self.in_stock ||= 0
    self.sold ||= 0
  end
end
