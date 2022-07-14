require_relative 'json_reader_writer'

class Printer
  def self.export_receipt(books, receipt)
    json = merge_receipt_with_books(books, receipt)
    JsonReaderWriter.export_to_file(json)
  end

  def self.merge_receipt_with_books(books, receipt)
    receipt[:books] = books.map(&:to_h)
    receipt
  end
end
