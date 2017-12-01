require 'socket'

class ParsedTweetEntry < ParsedEntry

  def initialize(tweet, feed_url)
    @tweet = tweet
    @feed_url = feed_url
  end

  def entry_id
    @tweet.id
  end

  def author
    @tweet.user.name || "@#{@tweet.user.name.screen_name}"
  end

  def content
    Twitter::Autolink.auto_link_with_json(@tweet.full_text, @tweet.to_hash[:entities])
  end

  def data
    value = {}
    value["tweet"] = @tweet.to_h
    value
  end

  def published
    @tweet.created_at
  end

  def title
    nil
  end

  def url
    @tweet.url.to_s
  end

end