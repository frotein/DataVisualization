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

    def self.getNames
      	result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions").read)
        m = []
        result[0].each_with_index do |dat, index|
            m[index] = dat[0]    
        end
        m
    end

    def self.geByUserID(id)
        result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/" + id).read)
    end
end
