class ByAttributeController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
    @names = DataMatrix.getNames()
    @valid_ids = DataMatrix.validIds
  end

  def show
    
    @names = DataMatrix.getNames()
    @user_id = params[:from]
    @valid_ids = DataMatrix.validIds
    

    result = DataMatrix.getByUserID(@user_id)
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
      f.title(:text => "User " + @user_id)

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