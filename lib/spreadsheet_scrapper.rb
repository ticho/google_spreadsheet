# frozen_string_literal: true

class SpreadsheetScrapper
  def initialize(data)
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    @session = GoogleDrive::Session.from_config("config.json")
    @ws = @session.spreadsheet_by_key("110E3Q7fHbPnCwnRi1waghV1YvHenIDP7YhBZYt6Mdmc").worksheets[0]
    @data = data
  end

  def write_data_to_spreadsheet
    @data.each_with_index do |city, index|
      @ws[2 + index, 1] = city["name"]
      @ws[2 + index, 2] = city["email"]
    end
    @ws.save
  end
end
