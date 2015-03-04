class Game < ActiveRecord::Base
	field :id, :type => Integer
	field :name, :type => String
	field :creator, :type => String
	field :tracked_variables: :type => Hash #var_name => type of var
	has_many :game_sessions
end