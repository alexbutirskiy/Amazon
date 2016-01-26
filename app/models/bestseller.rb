class Bestseller
  attr_reader :book, :rank
  def initialize(rank)
    unless (1..bestsellers_max).include?(rank)
      raise ActiveRecord::RecordNotFound, "Wrong rank #{rank} given"
    end
    
    @book = Book.order(sold: :desc).offset(rank - 1).limit(1).first
    @rank = rank
  end

  def first?
    self.rank == 1
  end

  def last?
    rank == bestsellers_max
  end

  private

  def bestsellers_max
    [ Book.count, Book::BESTSELLERS_COUNT ].min
  end

end