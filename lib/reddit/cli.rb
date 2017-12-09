class Reddit::CLI
  def call
    @subreddit = ARGV[0] || "ruby"
    puts "Here's the current hot list on r/#{@subreddit}"
    show_posts(@subreddit)
    menu
  end

  def openInBrowser(url)
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
      system "start #{url}"
    elsif RbConfig::CONFIG['host_os'] =~ /darwin/
      system "open #{url}"
    elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
      system "xdg-open #{url}"
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts ""
      puts "> Enter the number of the post you'd like more info on:"
      input = gets.strip.downcase

      if input.to_i > 0
        show_post(input.to_i-1)
      elsif input == "list"
        show_posts
      elsif input == "exit" || input == "q"
        exit!
      else
        puts "> Not sure what you want, type list or exit."
      end
    end
  end

  def get_score_text(index)
    post = @posts[index.to_i]
    upvotes = post[:upvotes]
    if post[:upvotes].to_i == 1
      score = post[:upvotes].to_i >= 0 ? 'upvote' : 'downvote'
    else
      score = post[:upvotes].to_i >= 0 ? 'upvotes' : 'downvotes'
    end
    return "#{upvotes} #{score}"
  end

  def show_posts(subreddit)
    @posts = Reddit::Scraper.scrape(subreddit)
    @posts.each_with_index do |post, i|
      upvotes = get_score_text(i)
      index = "#{i + 1}"
      puts "#{index.bold}. #{upvotes} - #{post[:title]} by #{post[:author].bold}"
    end
  end

  def show_post(index)
    post = @posts[index.to_i]
    puts ""
    puts "Title: #{post[:title]}"
    puts "Author: #{post[:author]}"
    puts "Score: #{post[:upvotes]}"
    puts "Comments: #{post[:comments]}"
    puts "Posted: #{post[:timestamp]}"
    puts ""
    input = nil
    while input != "exit"
      puts "> Enter the option you'd like to perform:"
      puts "1. Open in browser"
      puts "2. Show hot posts"
      puts "3. Exit"
      puts ""
      input = gets.strip.downcase
      if input.to_i == 1
        openInBrowser(post[:url])
      elsif input.to_i == 2
        show_posts
        break
      elsif input.to_i == 3 || input == "exit" || input == "q"
        exit!
      else
        puts "> Not sure what you want, type list or exit."
      end
    end
  end
end