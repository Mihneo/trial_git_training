require_relative 'json_reader_writer'
require_relative 'book'
require 'json'

class Cart
  attr_accessor :total, :item_count, :item_list, :sub_total, :promotion

  def initialize
    @total = 0
    @item_count = 0
    @sub_total = 0
    @promotion = 0
    @item_list = []
  end

  def add_item(item)
      @item_list << item unless item.nil?
  end

  def clear_cart
    initialize
  end

  def calculate_total
    @item_list.each do |item|
      @total += item[:price] * item[:qty]
    end
    check_and_apply_promotion
  end

  def check_and_apply_promotion
    if @total > 100
      @sub_total = @total
      @promotion = (@sub_total * 0.1).to_i
      @total -= @promotion
    end
  end

  def calculate_count
    @item_list.each do |item|
      @item_count += item[:qty]
    end
  end

  def calculate_qty
    item_list_to_h.tally
  end

  def prepare_items_with_qty
    cart_items = []
    quantities = calculate_qty
    quantities.each do |item_quantity|
      if item_quantity[1] > item_quantity[0][:stock]
        item_quantity[1] = item_quantity[0][:stock]
      end
      item_quantity[0][:qty] = item_quantity[1]
      cart_items << item_quantity[0]
    end
    @item_list = cart_items.map { |item| item.except(:stock) }
  end

  def to_h
    { cart: {total: @total, item_count: @item_count, cart_items: @item_list, sub_total: @sub_total, promotion: @promotion} }
  end

  def item_list_to_h
    @item_list.map(&:to_h)
  end
end
