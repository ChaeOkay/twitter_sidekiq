class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username

  def self.log_new(token)
    User.create( username: token.params[:screen_name],
                        oauth_token: token.token,
                        oauth_secret: token.secret)
  end

  def tweet(msg)
    tweet = Tweet.create!(:status => msg)
    self.tweets << tweet
    TweetWorker.perform_async(tweet.id)
  end

end
