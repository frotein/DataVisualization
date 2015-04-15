class ByAttributeController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
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
    @line = @mat.column(1).to_a.to_s[1 .. -2]
  end

  def show
    result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/117").read)
    @names = DataMatrix.getNames()
    @user_id = params[:from]
    @rows = Hash.new
    params.each do |key, value|
      if key.start_with?("display_me_")
        @rows[value] = []
      end
    end
    result.each do |record|
      @rows.each_key do |attri|
        @rows[attri].push(record[attri])
      end
    end
    m2 = @rows
    
    @mat = Matrix[*m2]
    i = 0
     @chartty = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Comparing attribute 6")

      f.xAxis[
        {:title => {:text => "Unique ID", :margin => 70} }
             ]
      @rows.each do |key, value|
        f.series(:name => key, :yAxis => 0, :data => value)
      end
      
      f.yAxis [
        {:title => {:text => "Attribute Value", :margin => 70} }
             ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
    
  end
end