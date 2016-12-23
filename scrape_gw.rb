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
p doc
mon_data1 = doc.xpath('/html/body/page-wrap/wrapper/main_wrap/main-col-wrap/content-wrap/article-wrap/article-body')
mon_data2 = doc.css('table')
puts mon_data2
=end

mon1 =  doc.xpath("//div[@class = 'monst-table-size']/table[2]")
mon2 = doc.xpath("//div[@class = 'js-accordion-area accordion-area'][1]/table[1]")
File.open("output1.txt", "w") do |f|
  f.puts("#{mon1}")
end

File.open("output2.txt", "w") do |f|
  f.puts("#{mon2}")
end
#//*[@id="article-body"]/div[6]