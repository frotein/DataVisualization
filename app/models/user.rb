class User < ActiveRecord::Base
	field :id, :type => Integer
	field :email, :type => String
	field :name, :type => String
	has_many :game_sessions
end