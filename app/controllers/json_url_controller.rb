class JsonUrlController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
  	 
    @rows = DataMatrix.getData();
    m2 = @rows

    @mat = Matrix[*m2]
    i = 0
     @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Comparing attribute 6")

      f.xAxis(:categories => [ 1 , 2, 3, 4, 5])
      f.series(:name => "attribute 6", :yAxis => 0, :data => @mat.column(1))
      
      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} }
             ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  
     render "charts" , layout: "application"
  end



  
end
