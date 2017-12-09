class Reddit::Scraper
  attr_accessor :title, :author, :timestamp, :comments, :upvotes, :url
  def self.scrape(subreddit)
    url = "https://www.reddit.com/r/#{subreddit}"
    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby-reddit'))
    posts = []
    postsList = doc.css('#siteTable > div.thing.link').first(10)
    postsList.each do |post|
      title = post.css('.title a.title').text.strip
      author = post.css('.author').text.strip
      timestamp = post.css('.live-timestamp').text.strip
      comments = post.attr('data-comments-count')
      upvotes = post.attr('data-score')
      url = post.css('a.comments').attr('href')
      newPost = {
        title: title,
        author: author,
        timestamp: timestamp,
        comments: comments,
        upvotes: upvotes,
        url: url,
      }
      posts << newPost
    end
    posts
  end
end