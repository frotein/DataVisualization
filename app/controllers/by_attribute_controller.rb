class ByAttributeController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
  	@dropdown = []
    @names = DataMatrix.getNames()
    @rows = User.getData(117, 3)
    m2 = @rows
    
    @mat = Matrix[*m2]
    i = 0
     @chartty = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Comparing attribute 6")

      f.xAxis[
        {:title => {:text => "Unique ID", :margin => 70} }
             ]
      f.series(:name => "attribute 6", :yAxis => 0, :data => @mat.column(1))
      
      f.yAxis [
        {:title => {:text => "Attribute Value", :margin => 70} }
             ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  end

end