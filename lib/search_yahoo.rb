class Search_Yahoo
  def self.run

    agent = Mechanize.new

    page = agent.get('https://tw.yahoo.com/')
    yahoo_form = page.form


    @hospitals = Hospital.all

    @hospitals[900,1015].each do |h|

      url_list = []
      name = h.name
      yahoo_form.p = name
      page = agent.submit(yahoo_form, yahoo_form.buttons.first)
      
      page.links.each do |link|
        url = link if link.text.start_with?(name[0,4]) && link.href !~ /(hhw|lifeshow|sixstar|realsun|scmszc|fglife|cych|tylife|makesop|tel038|medicallab|deefeed|doctorknow|youtube|pchome|bamahome|319papago|doctor.tw|finddoc|yahoo|doctor01|ezlife|5151|facebook|ipeen|104hc|verywed|bizpo|1111|twypage|tw16|google|businessweekly|goo|wakema|pixnet|iyp|xuite|sina|wikia|nownews|commonhealth|nhi|healthnews|socailiao|web393|wikipedia|mywoo|104|mohw|lifego|ypgo|yes123|blogspot|16won|4a0b|yelp|twspecial|fuly|healthmedia|shsh|qmap|zhupiter|ilist|dmbom|yam|lecoin|iask|shopcool|datagovtw|518|pixstu|iguang|urmap|yeahday|cmoremap|lookup|hicare|itwyp|tut|medicaltravel|dadupo|tophealthclinics|medicaltravel|roodo|itel|salary|web66|hotfrog|ibeta|abiz|olc|freeweb|ck101|1673|121|freelist|taiwanschoolnet|tw66|wordpress|babyhome|fashionguide|gothejob|chcg|lienchiangcounty4|likeboy|fescomail|dradvice|hcl)/    
        url_list << url.href if !url.nil?
        url_list.uniq!
      end
      @hospital = Hospital.find_by(:name => name)
      if url_list.empty?
        @hospital.website = "N/A"
        @hospital.save
      else  
        @hospital.website = url_list[0]
        @hospital.save
      end

    end; true
  end
end

#yahoo
#page.css('.addr .wrap').text
#=> "新北市三重區仁愛街731號"

#page.css('.phone').text
#=> "02-2286-6788"

#google
#page.css('span._tA')[0].text
#=> "105台北市松山區八德路四段659號"

#page.css('span._tA')[3].text
#=> "02 2763 1678"

