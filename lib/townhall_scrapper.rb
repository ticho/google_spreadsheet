# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

class TownhallScrapper
  def initialize(url = '')
    @url = if url == ''
             'http://annuaire-des-mairies.com/val-d-oise.html'
           else
             url
           end
  end

  def list
    get_all_the_urls_of_val_doise_townhalls(@url)
  end

  private

  def get_the_email_of_a_townhal_from_its_webpage(url)
    page = Nokogiri::HTML(URI.open(url))
    page.css('td').each do |str|
      if str.text.chomp.match?(/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i)
        return str.text
      end
    rescue StandardError => e
      puts "Error with #{str.text}: #{e.message}"
    end
    ''
  end

  def get_all_the_urls_of_val_doise_townhalls(url)
    page = Nokogiri::HTML(URI.open(url))
    page = page.css('a').select do |a|
      a['class'] == 'lientxt'
    end
    town_list = []
    page.each do |a|
      # page.first(20).each do |a|
      email = get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com' + a['href'][1..-1])
      town_list.push(name: a.text, email: email)
    rescue StandardError => e
      puts "Error with #{str.text}: #{e.message}"
    end
    town_list
  end
end
