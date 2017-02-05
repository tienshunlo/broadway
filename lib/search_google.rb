
require 'open-uri'
require 'nokogiri'
require 'mechanize'

class Search_Google
  def self.run
  
    mechanize = Mechanize.new
    page = mechanize.get('https://www.google.com.tw/search?q=%E5%A9%A6%E7%94%A2%E7%A7%91')
    
    #google_url = "https://www.google.com.tw"
    #basic_url = "/search?q=%E5%A9%A6%E7%94%A2%E7%A7%91"
    #puts page.uri
    
    next_page = nil
    next_page = !page.link_with(text: '下一頁').nil? ? page.link_with(text: '下一頁') : nil
    
    counter = 1
    begin
    new_page = next_page.click if !next_page.nil?
      puts next_page.href
      new_page.css('//h3').each do |h|
        puts h.text
      end
      next_page = !new_page.link_with(text: '下一頁').nil? ? new_page.link_with(text: '下一頁') : nil
      puts next_page.href if !next_page.nil?
      new_page = !next_page.nil? ? next_page.click : nil
      counter += 1 if !next_page.nil?
    end while !next_page.nil?
  end
end
