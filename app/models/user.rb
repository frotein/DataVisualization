class User < ActiveRecord::Base
	field :id, :type => Integer
	field :name, :type => String
	field :creation_date, :type => Time
	field :updation_date, :type => Time
end