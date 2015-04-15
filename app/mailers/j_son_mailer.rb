class JSonMailer < ActionMailer::Base
  default from: "Crackle@Barrel.com"
  def welcome_email(user)
    @user = user
    @code  = 'Input Code'#generate code here
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
