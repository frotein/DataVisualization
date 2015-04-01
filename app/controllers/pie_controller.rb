class PieController < ApplicationController

	require 'json'
	require 'open-uri'
	require 'matrix'
	
  def inspectKeys(all_array)
    ret_array = []
    for element in all_array
      ret_array.push(element[0])
    end
    return ret_array
  end

  def new
  	@dropdown = []
    @names = DataMatrix.getNames() 
    @rows = DataMatrix.getData()
    m2 = @rows
   
    
    @mat = Matrix[*m2]
  	c = @mat.column(8)
  	my_row = c.to_a()

    pieHash = []
    for item in my_row
      if(inspectKeys(pieHash).include? item)
        for current_position in 0..(pieHash.length-1)
          if pieHash[current_position][0] == item
            pieHash[current_position][1] += 1
          end
        end
      else
        pieHash.push([item, 1])
      end
    end
    @chart = LazyHighCharts::HighChart.new('pie') do |f|
    f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
    series = {
             :type=> 'pie',
             :name=> 'Shared entry',
             :data=> pieHash,
    }
    f.series(series)
    f.options[:title][:text] = "Pie Chart"
    f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
    f.plot_options(:pie=>{
      :allowPointSelect=>true, 
      :cursor=>"pointer" , 
      :dataLabels=>{
        :enabled=>true,
        :color=>"black",
        :style=>{
          :font=>"13px Trebuchet MS, Verdana, sans-serif"
        }
      }
    })
	end
end
end