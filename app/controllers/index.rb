get '/' do
  erb :index
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

require 'pry'
get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)


  @user = User.find_by_username(@access_token.params[:screen_name])
  @user = User.log_new(@access_token) if @user.nil?

  erb :index
end

post '/:user_id/tweet' do
  @msg = params['message']
  user = User.find(params[:user_id])
  user.tweet(@msg)

  erb :_confirm, layout: false
end
