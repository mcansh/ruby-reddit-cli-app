class Reddit::CLI
  def call
    Reddit::Scraper.scrape
    puts "Here's the current hot list on r/ruby"
    start
  end

  def start
    show_posts
  end

  def show_posts
    @posts = Reddit::Scraper.scrape
    @posts.each_with_index do |post, i|
      puts "#{i + 1}. #{post[:title]}"
    end
  end
end