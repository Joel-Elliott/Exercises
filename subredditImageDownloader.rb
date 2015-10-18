require 'open-uri'
require 'redditkit'

def download_imgur(url, filename)
  image = open("#{url}").read
  File.write("./downloaded/#{filename}", image)
end

client = RedditKit::Client.new
client.user_agent = 'subreddit Image Downloader'
#p client.user_agent

subreddit = 'aww'
#set this to change the subreddit
posts = client.links subreddit, :limit => '25'
#acquire posts from previously specified subreddit
posts.each.with_index(0) do |r, i|
  if r.image_link?
    puts "Downloading #{i}"
    download_imgur r.url, "#{subreddit}#{i} #{Time.now.strftime("%d-%m-%Y")}"
    #downloads each file and names it after the subreddit
  end
  sleep(2)
end
