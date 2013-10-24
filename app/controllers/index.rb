get '/' do
	@allevents = Event.all
  erb :index
end

get '/login' do
	erb :login_signup
end

get '/logout' do
	session.clear
	redirect '/'
end

get '/newevent' do
	if current_user
		@user = User.find(session[:id]).id
			erb :newevent
	end
end

get '/newevent_from_button' do
	if request.xhr?
		erb :newevent, layout: false
	else
		redirect '/newevent'
	end
end

get '/profile/:user_id' do
	@user = User.find(params[:user_id])
	erb :profile
end

get '/event/:event_id' do
	@event = Event.find(params[:event_id])
	erb :singleevent
end

get '/event/edit/:event_id' do
	@event = Event.find_by_id(params[:event_id])
	if @event.user == current_user
		erb :editevent
	else
		erb :singleevent
	end
end

get '/event/delete/:event_id' do
	@event = Event.find_by_id(params[:event_id])
	if @event.user == current_user
		@event.destroy
		redirect '/'
	else
		redirect '/'
	end
end

#========== POST

post '/newuser' do
	@user = User.create(params[:newuser])
	redirect '/'
end

post '/login' do
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      session[:id] = @user.id
      redirect "/profile/#{session[:id]}"
    else
      redirect '/login'
    end
  erb :profile
end

post '/event/edit' do
	@event = Event.find(params[:id])
	if @event.update_attributes(params[:event])
		redirect "/event/#{event_id}"
	end
end

post '/event/:event_id/destroy' do
	@event = Event.find(params[:id])
	user_id = @event.user_id
		if @event.destroy
		redirect "profile/#{user_id}"
		else
		redirect '/'
	end
end

post '/newevent' do
	@user_id = User.find(session[:id])
	@event = Event.create(name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at], user_id: session[:id])
	if @event.valid?
		if request.xhr?
			erb :_created_event_row, layout: false, locals: { event: @event }
		else
			redirect '/'
		end
	end
end