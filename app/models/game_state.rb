class game_state < ActiveRecord::Base
	field :id, :type => Integer
	field :hash, :type => String #the compressed version of the state sent to the game for parsing
	has_one game
	#whatever fields the game wants to base the hashstring off of. might need to auto generate per game. probably going to be a json blob
	field :state_data, :type => String
end