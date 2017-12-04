class Reddit::Scraper
  attr_accessor :title, :author, :timestamp, :comments, :upvotes
  def self.scrape
    doc = Nokogiri::HTML(open("https://www.reddit.com/r/ruby", 'User-Agent' => 'ruby-reddit'))
    posts = []
    postsList = doc.css('#siteTable > div.thing.link').first(10)
    postsList.each do |post|
      title = post.css('.title a.title').text.strip
      author = post.css('.author').text.strip
      timestamp = post.css('.live-timestamp').text.strip
      comments = post.css('.comments').text.strip
      upvotes = post.css('.score.unvoted').text.strip
      posts << {title: title, author: author, timestamp: timestamp, comments: comments, upvotes: upvotes}
    end
    posts
  end
end