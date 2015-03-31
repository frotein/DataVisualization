class JsonUrlController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
  	 
    @result = JSON.parse(open("http://localhost:10003/GL_VPAL_Interactions").read)
    @names = []
	i = 0
    
    m2 = [[]]
    (0..200).each do |x|
    m2[x] = []
    	(0..15).each do |y|
    	m2[x][y] = 0
    	end
    end

    @result[0].each do |dat|
 		
    	@names[i] = dat.first
    	i = i + 1
    end
    p = 0
    c = 0
    l = 0
    m2[c][0] = 0

    @result.each_with_index do |dat, index|
    	m2[index] = []
    	
    	dat.each_with_index do |num,index2|
    	m2[index][index2] = num[1]
    	end
    end
    @rows = m2

    mat = Matrix[*m2]
    i = 0
     @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Comparing attribute 6")

      f.xAxis(:categories => [ 1 , 2, 3, 4, 5])
      f.series(:name => "attribute 6", :yAxis => 0, :data => mat.column(1))
      
      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} }
             ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  
     render "charts" , layout: "application"
  end



  
end
