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
    @checks = [params[:a], params[:b],params[:c],params[:d],params[:e],params[:f],params[:g] ]
    @names = DataMatrix.getNames() 
    @rows = DataMatrix.getData()
    m2 = @rows
   my_row = []
    @chart = []
    @mat = Matrix[*m2]
    chartRow = 0
    @checks.each_with_index do |c,index|
        if(c != nil)
        my_row = @mat.column(index).to_a()
        pieHash = []
        for item in my_row
          if(inspectKeys(pieHash).include? item.to_s)
            for current_position in 0..(pieHash.length-1)
              s = item.to_s
              if pieHash[current_position][0] == s
                pieHash[current_position][1] += 1
              end
            end
          else
            pieHash.push([item.to_s, 1])
          end
        end

        @chart[chartRow] = LazyHighCharts::HighChart.new('pie') do |f|
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
    chartRow+=1
    end
  end
end
end