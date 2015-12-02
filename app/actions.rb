helpers do
   
    #returns nil if no user found
    def current_user
       @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
   
    def check_user_signed_in
        if session[:user_id] == nil
            redirect '/login' 
        end 
    end
        
   
    def readable_date(date)
        date.strftime("%B %e, %Y") 
        # outputs something like December 24, 1986
    end 
end

get '/' do
    # todo : get users from db 
    @users = User.all
    erb :index
end

get '/users' do
    @users = User.all
    #we have a list of users
    erb :users
end

get '/signup' do
   erb :signup
end
post '/signup' do
    
    @username = params[:username]
    @avatar_url = params[:avatar_url]
    @email = params[:email]
    
    if params[:password] == params[:password_confirmation]
        
        password = params[:password]
        password_confirmation = params[:password_confirmation]
        
        user = User.new(username: @username,
                        password: password,
                        avatar_url: @avatar_url,
                        email: @email)
        
        if user.save
            session[:user_id] = user.id
            redirect '/buildings'
        else
            erb :signup
        end
        
    else
        @errors = ["Your passwords don't match!"]
        erb :signup
    end
    
end

get '/login' do
    erb :login
end
post '/login' do
  
  username = params[:username]
  password = params[:password]
  
  user = User.find_by_username(username)
  
  # check if user exists and password matches
  if user && password == user.password
    #yay, got a match    
    session[:user_id] = user.id # log the user in
    redirect '/' # redirect to home or main listing area
  else
      #didn't work 
    erb :login
  end
end

get '/logout' do
    
    # unset the session
    session[:user_id] = nil
    
    # send them home or to the login screen 
    redirect '/'
end

get '/buildings' do

    #implement a search here
    if params[:keywords].nil? 
        @buildings = Building.all
    else #user did search something...
        # @buildings = Building.where('name = ?', params[:keywords])
        @buildings = Building.where('name LIKE ?', "%#{params[:keywords]}%")
    end
    
    erb :'buildings/index'
end

get '/buildings/new' do

    check_user_signed_in

    @cities = City.all
    erb :'buildings/new'
end

post '/buildings/new' do
    
    #make a new building
    # binding.pry
    name = params[:name]
    img_src = params[:img_src]
    height_m = params[:height_m]
    date_built = params[:date_built]
    is_ugly = params[:is_ugly]
    city_id = params[:city_id]
    
    @building = Building.new(name: name, img_src: img_src, height_m: height_m, date_built: date_built, is_ugly: is_ugly, city_id: city_id)
    
    # building.save will either pass or fail here
    if @building.save
        # if save works redirect to the listings
        redirect '/buildings/index'
    else
        @cities = City.all
        # otherwise, load the form again
        erb :'buildings/new'
    end
end


get '/help' do
    erb :help
end
get '/contact' do
    erb :contact
end