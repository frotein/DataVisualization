class JsonUrlController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'
  require 'csv'

  def new
    @names = DataMatrix.getNames()
    valid_ids = DataMatrix.validIds
    valid_ids = valid_ids.sort
    @min = valid_ids.first
    @max = valid_ids.last
  end
  
  def download 
     @s = params[:car]
     send_data(@s, :filename => "Data.csv")
  end

  def show
    @names = DataMatrix.getNames() 
    @valid_ids = DataMatrix.validIds
    @return_csv = params[:returnc]
    @from  = params[:from]
    @to = params[:to]
    @valid_ids.sort
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
      result = DataMatrix.getByUserID(id.to_s)
      result = result.take(1)

      result.each do |record|
        @rows.each_key do |attri|
          @rows[attri].push(record[attri])
          @user_records[id].push(record[attri])
        end
      end
    end

    @s = CSV.generate do |csv| @rows.to_a.each do |elem| csv << elem end end
    
    @chart_attribute = LazyHighCharts::HighChart.new('GroupByAttr') do |f|
      f.title(:text => "Most Recent Values of " + @rows.keys.join(", ") + " by Attribute")
      
      f.xAxis(:categories => @rows.keys)

      @user_records.each do |key, value|
        f.series(:name => "User "+key.to_s, :yAxis => 0, :data => value)
      end    
      f.yAxis(:title => {:text => "Player Attributes Comparison"} )

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical')
      f.chart({:defaultSeriesType=>"column"})
    end

    @chart_user = LazyHighCharts::HighChart.new('GroupByUser') do |f|
      f.title(:text => "Most Recent Values of " + @rows.keys.join(", ") + " by User Id")
      
      f.xAxis(:categories => @user_records.keys, :title => {:text => "User Id", :margin => 70})

      @rows.each do |key, value|
        f.series(:name => key.to_s, :yAxis => 0, :data => value)
      end    
      f.yAxis(:title => {:text => "Player Attributes Comparison", :margin => 70} )

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical')
      f.chart({:defaultSeriesType=>"column"})
    end

  end

end