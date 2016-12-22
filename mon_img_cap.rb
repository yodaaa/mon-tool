# coding: utf-8
require "open-uri"
require 'FileUtils'

#ex) ruby mon_img_cap.rb 1 2 3 4 5
id_list = []
while id=ARGV.shift
  id_list.push(id)
end

def save_image(url)
  # ready filepath
  fileName = File.basename(url)
  dirName = "img/"
  filePath = dirName + fileName

  # create folder if not exist
  FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

  # write image adata
  open(filePath, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end
end

id_list.each do |i|
  url = "https://gamewith.akamaized.net/article_tools/monst/gacha/#{i}.jpg"
  puts "#{i}:#{url}"
  save_image(url)
end