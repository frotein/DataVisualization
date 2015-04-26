class GameStatus < ActionMailer::Base
  default from: "from@example.com"

  def invitation_email(email, options, json_codes)
  	game_name = options["game_name"]
  	@researcher_name = options["researcher_name"]
  	@description = options["description"]
  	@game_url = options["game_url"]
  	@contact_info = options["contact_info"]
  	@json_code = json_codes

  	mail(to: email, subject: "Invitation to play " + game_name)
  end
end
