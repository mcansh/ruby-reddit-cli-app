class Reddit::Post
  attr_accessor :title, :author, :timestamp, :comments, :upvotes, :url

  @@post = []

  def initialize(title, author, timestamp, comments, upvotes, url)
    @title = title
    @author = author
    @timestamp = timestamp
    @comments = comments
    @upvotes = upvotes
    @url = url

    @@post << self
  end

  def self.all
    @@post
  end
end
