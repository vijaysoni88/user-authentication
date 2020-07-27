class SessionsController < ApplicationController
	def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.signed[:user_id] = { value: user.id, expires: 2.weeks.from_now }
      # Save the user id inside the browser cookie. This is how we keep the user  remember_me(user)
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    end
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete :user_id
    redirect_to '/login'
  end
end
