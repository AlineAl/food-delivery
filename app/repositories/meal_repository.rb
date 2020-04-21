require_relative "base_repository"
require_relative "../models/meal"

class MealRepository < BaseRepository
  private

  def build_headers
    %w[id name price]
  end

  def build_row(element)
    [element.id, element.name, element.price]
  end

  def build_element(row)
    row[:price] = row[:price].to_i
    Meal.new(row)
  end
end
