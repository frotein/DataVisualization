class Player_Positions < ActiveRecord::Base
	field :user_id, :type => Integer
	field :type, :type => String
	field :user_x_pos, :type => Fload
	field :user_y_pos, :type => Float
	field :game_time, :type => Float
	field :camera_x_pos, :type => Float
	field :camera_y_pos, :type => Float
	field :camera_z_pos, :type => Integer
	field :creation_date, :type => Time
	field :updation_date, :type => Time
end