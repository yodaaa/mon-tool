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
mon_data = doc.css('table')
puts mon_data
=end

mon1 =  doc.xpath("//div[@class = 'monst-table-size']/table[2]")
mon2 = doc.xpath("//div[@class = 'js-accordion-area accordion-area'][1]/table[1]")

=begin
#イベントスケジュール(星4)
mon3 =doc.xpath("//*[@id='article-body']/table")
mon4 = doc.xpath("//div[@class = 'js-accordion-area accordion-area'][2]/table[1]")
=end

File.open("data/output1.txt", "w") do |f|
  f.puts("#{mon1}")
end

File.open("data/output2.txt", "w") do |f|
  f.puts("#{mon2}")
end

