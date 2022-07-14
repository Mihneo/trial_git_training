require 'ostruct'

class Book
  attr_accessor :id, :title, :price, :stock

  def initialize(id, title, price, stock)
    @id = id
    @title = title
    @price = price
    @stock = stock
  end

  def to_h
    { id: @id, title: @title, price: @price, stock: @stock }
  end
end
