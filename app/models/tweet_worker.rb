class TweetWorker
  include Sidekiq::Worker

# require 'pry'
  def perform(tweet_id)
    # binding.pry
    puts "*" * 80
    puts "starting #{jid}"
    puts "sleeping...."

        sleep rand(10)
    tweet = Tweet.find(tweet_id)
    user = tweet.user

    tweeter = Twitter.configure do |config|
      config.oauth_token = user.oauth_token
      config.oauth_token_secret = user.oauth_secret
    end
    tweeter.update(tweet.status)

    puts "...done sleeping"
    puts "*" * 80
    #tweet message
    #load erb
  end

end
