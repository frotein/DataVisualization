class JsonUrlController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
    @names = DataMatrix.getNames()
    valid_ids = DataMatrix.validIds
    valid_ids = valid_ids.sort
    @min = valid_ids.first
    @max = valid_ids.last
  end

  def show
    @names = DataMatrix.getNames() 
    @valid_ids = DataMatrix.validIds
    @from  = params[:from]
    @to = params[:to]

    @min = @valid_ids.first
    @max = @valid_ids.last

    @valid_ids.delete_if{|val| val < @from.to_i || val > @to.to_i}
    @user_records = Hash.new
    
    @rows = Hash.new
    params.each do |key, value|
      if key.start_with?("display_me_")
        @rows[value] = []
      end
    end
    @valid_ids.each do |id|
      @user_records[id] = []
      result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/"+ id.to_s).read)
      result = result.take(1)

      result.each do |record|
        @rows.each_key do |attri|
          @rows[attri].push(record[attri])
          @user_records[id].push(record[attri])
        end
      end
    end
    @chart = LazyHighCharts::HighChart.new('GroupByUser') do |f|
      f.title(:text => "Most Recent Values of " + @rows.keys.join(", "))
      
      f.xAxis(:categories => @rows.keys)

      @user_records.each do |key, value|
        f.series(:name => "User "+key.to_s, :yAxis => 0, :data => value)
      end    
      f.yAxis(:title => {:text => "Player Attributes Comparison", :margin => 70} )

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical')
      f.chart({:defaultSeriesType=>"column"})
    end
  end

end