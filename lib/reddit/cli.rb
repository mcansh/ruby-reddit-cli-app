class Reddit::CLI
  def call
    puts "Here's the current hot list on r/ruby"
    show_posts
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
      puts "Enter the number of the post you'd like more info on:"
      input = gets.strip.downcase

      if input.to_i > 0
        show_post(input.to_i-1)
      elsif input == "list"
        show_posts
      elsif input == "exit"
        break
      else
        puts "Not sure what you want, type list or exit."
      end
    end
  end

  def get_score_text(index)
    post = @posts[index.to_i]
    score = post[:upvotes].to_i >= 0 ? 'upvotes' : 'downvotes'
    upvotes = post[:upvotes].to_i < 10 ? "0#{post[:upvotes]}" : "#{post[:upvotes]}"
    return "#{upvotes} #{score}"
  end

  def show_posts
    Reddit::Scraper.scrape
    @posts = Reddit::Scraper.scrape
    @posts.each_with_index do |post, i|
      upvotes = get_score_text(i)
      puts "#{i + 1}. #{upvotes} - #{post[:title]} by #{post[:author].bold}"
    end
  end

  def show_post(index)
    post = @posts[index.to_i]
    upvotes = get_score_text(index.to_i)
    puts ""
    puts "Title: #{post[:title]}"
    puts "Author: #{post[:author]}"
    puts "Score: #{post[:upvotes]}"
    puts "Comments: #{post[:comments]}"
    puts "Posted: #{post[:timestamp]}"
    puts ""
    input = nil
    while input != "exit"
      puts "Enter the option you'd like to perform:"
      puts "1. Open in browser"
      puts "2. Show hot posts"
      input = gets.strip.downcase
      if input.to_i == 1
        openInBrowser(post[:url])
      elsif input.to_i == 2
        show_posts
        break
      else
        puts "Not sure what you want, type list or exit."
      end
    end
  end
end