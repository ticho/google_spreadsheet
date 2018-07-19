# frozen_string_literal: true

require 'google_drive'
require_relative 'lib/townhall_scrapper'
require_relative 'lib/spreadsheet_scrapper'




def data_to_csv(data)
  file = open('db/emails.csv', 'w')
  file.write("\"name\",\"email\"\n")
  data.each do |line|
    file.write("\"#{line["name"]}\",\"#{line["email"]}\"\n")
  end
end

# scrapper

# data_to_csv(data_from_db)

# puts data_from_db

# SpreadsheetScrapper.new(data_from_db).write_data_to_spreadsheet

# puts TownhallScrapper.new("http://annuaire-des-mairies.com/ain.html").list_from_url
# puts TownhallScrapper.new("http://annuaire-des-mairies.com/finistere.html").list_from_url
# puts TownhallScrapper.new("http://annuaire-des-mairies.com/loire.html").list_from_url

finistere = TownhallScrapper.new("http://annuaire-des-mairies.com/finistere.html")
binding.pry
