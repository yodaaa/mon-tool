require 'open-uri'
require 'nokogiri'

url = 'https://xn--eckwa2aa3a9c8j8bve9d.gamewith.jp'

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

=begin
p doc.title #タイトル取得
p doc       #要素取得
mon_data = doc.css('table') #table要素全取得
puts mon_data
=end

mon1 = doc.xpath("//div[@class='monst-table-size']/table[2]/tr")
mon2 = doc.xpath("//div[@class='js-accordion-area accordion-area'][1]/table[1]/tr")

=begin
#イベントスケジュール(星4)
mon3 =doc.xpath("//*[@id='article-body']/table")
mon4 = doc.xpath("//div[@class='js-accordion-area accordion-area'][2]/table[1]")
=end

File.open("data/output1.txt", "w") do |f|
  f.puts("#{mon1}")
end

File.open("data/output2.txt", "w") do |f|
  f.puts("#{mon2}")
end
File.open("data/output_s.csv", "w") do |f|
  f.puts("")
end

def extraSchedule(mon)
  date_str=""
  str =""
  mon.each do |node|
    if(node.css('td').empty?)
      date_str = node.css('th[1]').inner_text
    else
      str << date_str + ","
      next if node.css('td[1]').empty?
      str << node.css('td[1]').inner_text
      str << ","
      next if node.css('td[2]').empty?
      str << node.css('td[2]').inner_text
      str << ","
      next if node.css('td[3]/a').empty?
      str << node.css('td[3]/a').attribute('href').value
      str << "\n"
    end
  end
  puts str
  File.open("data/output_s.csv", "a") do |f|
    f.puts("#{str}")
  end
end

extraSchedule(mon1)
extraSchedule(mon2)


