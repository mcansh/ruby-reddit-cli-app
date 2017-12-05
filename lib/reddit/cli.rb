class Reddit::CLI
  def call
    Reddit::Scraper.scrape
    puts "Here's the current hot list on r/ruby"
  def openInBrowser(url)
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      system "start #{url}"
    elsif RbConfig::CONFIG['host_os'] =~ /darwin/
      system "open #{url}"
    elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
      system "xdg-open #{url}"
    end
  end

  def start
    show_posts
  end

  def show_posts
    @posts = Reddit::Scraper.scrape
    @posts.each_with_index do |post, i|
      upvotes = post[:upvotes].to_i
      score = post[:upvotes].to_i >= 0 ? 'upvotes' : 'downvotes'

      puts "#{i + 1}. #{upvotes} #{score} #{post[:title]} by #{post[:author].bold}"
    end
  end
end