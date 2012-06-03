class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => [:google]

  def google
    @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      session[:user] = { id: @user.id, name: @user.name, email: @user.email }.to_json
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to root_url, :notice => 'You must use an approved e-mail to proceed.'
    end
  end
end