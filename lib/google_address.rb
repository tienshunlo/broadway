class Google_Address
  def self.run

    agent = Mechanize.new

    page = agent.get('https://google.com/')
    google_form = page.form('f')


    @hospitals = Hospital.all
    @hospitals[1000..1015].each do |hospital|
      hospital_name = hospital.name
      city_id = hospital.city_id
      city_name = City.find_by(:id => city_id).name
      google_form.q = city_name + hospital_name 
      page = agent.submit(google_form, google_form.buttons.first)
      
      if page.css("._gF").empty?
        hospital.info_others = "empty"
      else
        page.css("._gF").each do |f|
          if f.css("._gS").text == "地址： "
            hospital.info_address = f.css("._tA").text
          elsif f.css("._gS").text == "電話： "
            hospital.info_tel = f.css("._tA").text
          else 
            hospital.info_others =  f.css("._tA").text
          end
        end
      end
      hospital.save

    end; true
  
  end
end
      
#a = @hospitals.find_by(:id=>1999)
#a.info_address = "324桃園市平鎮區民族路199號"
#a.info_tel = "03 402 0999"
#a.website = "http://www.nhi.gov.tw/Query/Query3_Detail.aspx?HospID=3532110092"
#a.save

#if page.css("._gF").empty?
        #puts name + ":" + "empty"
      #else
        #page.css("._gF").each do |f|
          #if f.css("._gS").text == "地址： "
            #puts "地址： " + f.css("._tA").text
          #elsif f.css("._gS").text == "電話： "
            #puts "電話： " + f.css("._tA").text
          #else 
            #puts "開放時間： " + f.css("._tA").text
          #end
        #end
      #end



#google
#page.css('span._tA')[0].text
#=> "105台北市松山區八德路四段659號"

#page.css('span._tA')[3].text
#=> "02 2763 1678"

#@hospitals[0,50]: index 0 之後的50個
#@hospitals[50,123]: index 50 之後的123個

#@hospitals[0..50]: index 0 到 index 50
#@hospitals[0...50]: index 0 到 index 49

#ActiveRecord::StatementInvalid: Mysql2::Error: Incorrect string value: '\xA4\xE9\xA4\xBD\xA5\xF0'
#Mechanize::ResponseCodeError: 400 => Net::HTTPBadRequest for