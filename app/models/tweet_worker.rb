class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)

    sleep(5)
    tweet = Tweet.find(tweet_id)
    user = tweet.user

    tweeter = Twitter.configure do |config|
      config.oauth_token = user.oauth_token
      config.oauth_token_secret = user.oauth_secret
    end
    
    tweeter.update(tweet.status)
  end

end
