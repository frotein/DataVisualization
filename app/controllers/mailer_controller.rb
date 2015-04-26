class MailerController < ApplicationController
  require 'mail'
  def new
  end

  def create
  	email  = params[:email].to_s #Email to send to
    codes = params[:codes].to_s #game params to insert
    
    mail_info = Hash.new
    params.each do |key, value|
      if key.start_with?("var")
        mail_info[value] = params["val"+key.last]
      end
    end

    json_codes = mail_info.to_json.to_s
    
    GameStatus.invitation_email(email, params, json_codes).deliver
  end
end
