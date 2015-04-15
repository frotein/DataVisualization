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

    def self.getByUserID(id)
        result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/" + id).read)
        result
    end

    def self.validIds
        valid_ids_temp = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/").read).uniq
        valid_ids = []
        valid_ids_temp.each do |id|
          valid_ids.push(id["user_id"])
        end
        valid_ids
    end
end
