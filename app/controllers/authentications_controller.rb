class AuthenticationsController < ApplicationController

  require 'net/http'

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  def loginlapapaya    
  end

  def sign_in_lapapaya
    @email = params[:lapapaya][:email]
    @password = params[:lapapaya][:password]


    #require "net/http"
    my_connection = Net::HTTP.new('www.lapapaya.org', 80)
    response = my_connection.post('http://www.lapapaya.org/integracion/access.php', 'email='+@email+'&password='+@password)
    p response.body.inspect
    json_data = JSON.parse(response.body)

    @name = json_data['lapapaya_user']['name']
    @pass = json_data['lapapaya_user']['pass']
    @mail = json_data['lapapaya_user']['mail']

    @user = User.new :name => @name+"_prueba", :password => "basura", :email => @mail, :id => 'DEFAULT'

    p @user.inspect
    @user.password = @pass
    p @user.inspect

    #sign_in(:user, @user)

    #redirect_to root_path
  end
end
