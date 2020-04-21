require_relative "base_repository"
require_relative "../models/customer"

class CustomerRepository < BaseRepository
  private

  def build_row(element)
    [element.id, element.name, element.address]
  end

  def build_element(row)
    Customer.new(row)
  end
end
