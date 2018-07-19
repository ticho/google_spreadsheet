# frozen_string_literal: true

require 'json'
require 'google_drive'
require_relative 'lib/townhall_scrapper'
require_relative 'lib/spreadsheet_scrapper'

def scrapper
  json_list = TownhallScrapper.new.list.to_json
  f = open('db/emails.JSON', 'w')
  f.write(json_list)
  f.close
end

def data_from_db
  f = open('db/emails.JSON', 'r')
  list = ''
  while (line = f.gets)
    list += line
  end
  f.close
  JSON.parse(list)
end

def data_to_csv(data)
  file = open('db/emails.csv', 'w')
  file.write("\"name\",\"email\"\n")
  data.each do |line|
    file.write("\"#{line["name"]}\",\"#{line["email"]}\"\n")
  end
end

# scrapper

data_to_csv(data_from_db)

# puts data_from_db

# SpreadsheetScrapper.new(data_from_db).write_data_to_spreadsheet
