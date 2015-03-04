class game_session < ActiveRecord::Base
	field :id, :type => Integer
	has_one :user
	has_one :game_state
	#whatever data needs to be stored about the game. might need to be done on a per game basis, probably gonna end up being a json blob
	field :session_data, :type => String
end