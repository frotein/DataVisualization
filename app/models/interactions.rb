class Interaction < ActiveRecord::Base
	field :user_id, :type => Integer
	field :type, :type => String
	field :with, :type => String
	field :location, :type => String
	field :attribute_5, :type => Integer
	field :attribute_6, :type => Integer
	field :attribute_7, :type => Integer
	field :attribute_8, :type => Integer
	field :creation_date, :type => Time
	field :updation_date, :type => Time
end