require 'sinatra'

set :environment, :prduction

set :sessinons,
  expire_after: 7200,
  secret: 'abcdefghij0123456789'

get '/' do
  redirect '/login'
end

get '/login' do
  erb :login
end

post '/auth' do
  username = params[:uname]
  pass = params[:pass]

  if ((username == "foo") && (pass == "bar"))
    session[:login_flag] = true
    session[:testdata] = "Brontosaurus"
    redirect '/contentspage'
  else
    session[:login_flag] = false
    redirect '/failure'
  end
end

get '/contentspage' do
  if (session[:login_flag] == true)
    @a = session[:testdata]
    erb :contents
  else
    erb :badrequest
  end
end

get '/logout' do
  session.clear
  erb :logout
end

get '/failure' do
  erb :loginfailure
end