require 'csv'

class HistogramChartController < ApplicationController
  def new
    valid_ids = DataMatrix.validIds
    valid_ids = valid_ids.sort
    @minID = valid_ids.first
    @maxID = valid_ids.last

  	@csvHash = Hash.new
    @names = DataMatrix.getNames() 

    @rows = DataMatrix.getData()
    @freq = params[:freq].to_f
    if(@freq == nil || @freq == 0)
    @freq = 10
	  end

    @from  = params[:from]
  	@to = params[:to];

    if(@from != nil && @to != nil)
    min = @from.to_f
    max = @to.to_f
	else
	min = 0
	max = 100
	end
	myname = "test"
    @tracking = params[:a] 
    if(@tracking == nil)
    	@tracking = "user_id"
	end
	
    m2 = @rows

    @chart = []
    titles = []
    @mat = Matrix[*m2]
    @names.each_with_index do |c,index|
        
        if(c == @tracking)
        my_row = @mat.column(index).to_a()
        myname = c
        @histoAr = []
        temp = min
        ind = 0
	        while temp < max
				freqNum = 0	
				for item in my_row
		          if(temp < item.to_f && temp + @freq > item.to_f)
		            freqNum+=1
		          end
		        end
		        nd = (temp+ @freq).to_s
		        st = temp.to_s
		        title = (st + " to " + nd)
            titles[ind] = title
            @histoAr[ind] = freqNum
		        @csvHash[title] = freqNum
            temp += @freq
		        ind+=1
		    end

   		end

  		
      @s = CSV.generate do |csv| @csvHash.to_a.each do |elem| csv << elem end end
      

  		 @chart = LazyHighCharts::HighChart.new('graph') do |f|
	    f.title(:text => myname + " histogram")
	    to = min.to_i()
	    from = max.to_i()
	    f.xAxis(:categories => titles)
	    
	    @len =  to - from 
	    
	      
      f.series(:name => c, :yAxis => 0, :data => @histoAr) 
       f.yAxis [
      {:title => {:text => "Player Attributes Comparison", :margin => 70} }
           ]

    f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    f.chart({:defaultSeriesType=>"column"})   
      end

  	end




end
  
  def download 
     @s = params[:car]
     send_data(@s, :filename => "Data.csv")
  end



  def show
  
  end

end
