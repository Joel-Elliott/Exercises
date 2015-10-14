require 'open-uri'
require 'redditkit'

def download_imgur(url, filename)
  image = open("#{url}.jpg").read
  File.write("#{filename}.jpg", image)
end

client = RedditKit::Client.new
posts = client.links 'aww', :limit => '25'
posts.each.with_index(0) do |r, i|
  if r.image_link?
    puts "Downloading #{i}"
    download_imgur r.url, r.id
  end
  sleep(2)
end
