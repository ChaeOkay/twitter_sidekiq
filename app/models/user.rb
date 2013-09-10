class User < ActiveRecord::Base
validates_uniqueness_of :username

  def self.log_new(token)
    User.create( username: token.params[:screen_name],
                        oauth_token: token.token,
                        oauth_secret: token.secret)
  end

  def tweet(msg)
    env = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))
    tweeter = Twitter.configure do |config|
      config.consumer_key = env['TWITTER_KEY']
      config.consumer_secret = env['TWITTER_SECRET']
      config.oauth_token = self.oauth_token
      config.oauth_token_secret = self.oauth_secret
    end
    tweeter.update(msg)
  end

end
