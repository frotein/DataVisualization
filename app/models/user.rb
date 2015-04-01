class User < ActiveRecord::Base

    #takes in a string to match to and a int for the collumn to search through
    def self.getData(id, attribute)
        all = DataMatrix.getData
        m2 = [[]]
        x = 0
        all.each do |row|
            if row[attribute] == id
                m2[x] = []
        
                row.each_with_index do |num,index2|
                    m2[x][index2] = num
                end
                x = x+1
            end
        end
        m2
    end
end