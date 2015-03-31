class DataMatrix < ActiveRecord::Base

	def self.getData
		result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions").read)
		m2 = [[]]
		result.each_with_index do |dat, index|
    		
    		m2[index] = []
    	
    		dat.each_with_index do |num,index2|
    			m2[index][index2] = num[1]
    		end
    	end
    	m2
	end	  	
end
