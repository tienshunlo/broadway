require 'Mechanize'


class Hospitals

  def get_page(url)
    agent = Mechanize.new
    return agent.get(url) 
  end

  def get_page_and_split_list(name)
    page = get_page('https://tw.yahoo.com/')
    yahoo_form = page.form
    yahoo_form.p = name
    page = agent.submit(yahoo_form, yahoo_form.buttons.first)
    return page
  end


    

    
  
  def self.run
    url_list = []
    @hospitals = Hospitals.all
    @hospitals.each do |h|
      page = get_page_and_split_list(h.name)
      page.links.each do |link|
        url = link if link.text.start_with?(h.name[0,4]) && link.href.exclude?("yahoo") && link.href.exclude?("doctor01") && link.href.exclude?("ezlife") && link.href.exclude?("5151") && link.href.exclude?("facebook") && link.href.exclude?("ipeen") && link.href.exclude?("104hc") && link.href.exclude?("verywed") && link.href.exclude?("bizpo") && link.href.exclude?("1111") && link.href.exclude?("twypage") && link.href.exclude?("tw16") && link.href.exclude?("google") && link.href.exclude?("businessweekly") && link.href.exclude?("goo")
        url_list << url.href if !url.nil?
        url_list.uniq!
        @hospital = Hospital.where(:name => h.name)
        if url_list.empty?
          @hospital.website = "N/A"
        else
          @hospital.website = url_list[0]
        end
        @hospital.save    
      end
    end; true
  end
end