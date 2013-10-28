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
  redirect '/status'
end

get '/status' do

  stats = Sidekiq::Stats.new
  @failed = stats.failed
  @processed = stats.processed
  erb :_bkgnd, layout: false
end
