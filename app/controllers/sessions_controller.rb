class SessionsController < ApplicationController

  def new
  end

  def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    sign_in user
	if user.admin
      redirect_to "/users"
	  else
	  redirect_to "/credits"
	  end
  else
    flash[:error] = 'Invalid email/password combination'
      render 'new'
  end
  def redirect_start_page
     redirect_to '/credits'
  end
  end
  def destroy
    sign_out
    redirect_to root_url
  end
  
  
end
