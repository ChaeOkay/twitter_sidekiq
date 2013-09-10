class User < ActiveRecord::Base
validates_uniqueness_of :username

  def self.log_new(token)
    User.create( username: token.params[:screen_name],
                        oauth_token: token.token,
                        oauth_secret: token.secret)
  end
end
