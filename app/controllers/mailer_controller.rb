class MailerController < ApplicationController
  require 'mail'
  def new
  end

  def create
  	@email  = params[:email].to_s #Email to send to
    @codes = params[:codes].to_s #game params to insert
    mail = Mail.new
    mail['body'] = 'plz work plox'
    mail['from'] = "m@thew.rocks"
    mail[:to] = @email
    mail.subject = "testing 123"

    #mail = Mail.new do 
    #	from    'Cracker@Barrel.com'
  	#	to      @email.to_s
  	#	subject 'Codes to input in Game'
  	#	body    'waesxrbgnk' #Body that we want
    #end
    Mail.defaults do
    	delivery_method :smtp, address: "m@thew.rocks", port: 1025
    end
    puts "qqqqqqqqqq"
    puts mail.to_s
    puts "QQQQQQQQQQQQQ"
    
    mail.deliver!
  end
end
