require "csv"

class BaseRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @elements
  end

  def add(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def update(index, name, address)
    element = @elements[index]
    element.name = name
    element.address = address
    save_csv
  end

  def destroy(index)
    @elements.delete_at(index)
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %w[id name address]
      @elements.each do |element|
        csv << build_row(element)
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << build_element(row)
    end
    @next_id = @elements.last.id + 1 unless @elements.empty?
  end
end
