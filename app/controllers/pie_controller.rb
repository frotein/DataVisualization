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
    @names = DataMatrix.getNames()
    valid_ids = DataMatrix.validIds
    valid_ids = valid_ids.sort
    @min = valid_ids.first
    @max = valid_ids.last
  end

  def show
    @names = DataMatrix.getNames()
    @valid_ids = DataMatrix.validIds
    valid_ids = @valid_ids.sort
    
    @min = valid_ids.first
    @max = valid_ids.last
    @from  = params[:from]
    @to = params[:to]

    @attribute = params[:attribute]
    total = 0.0

    @valid_ids.delete_if{|val| val < @from.to_i || val > @to.to_i}
    @user_records = Hash.new
    
    @valid_ids.each do |id|
      @user_records["UID:" + id.to_s]
      result = JSON.parse(open("http://localhost:10009/GL_VPAL_Interactions/user_id/"+ id.to_s).read)
      result = result.first[@attribute]
      @user_records["UID:" + id.to_s] = result
      total = total + result.to_i
    end

    @user_records.each do |id|
      id = (100 * @user_records[id].to_i) / total
    end
    @pie_chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
              :type=> 'pie',
              :name=> 'Shared entry',
              :data=> @user_records.to_a
      }
      f.series(series)
      f.tooltip({pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'})
      f.options[:title][:text] = "Distribution of " + @attribute
      f.legend(:layout=> 'horizontal',:style=> {:left=> 'auto', :bottom=> '500px',:right=> '50px',:top=> '1000px'})
      f.plot_options(:pie=>{
        :allowPointSelect=>true, 
        :cursor=>"pointer" , 
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        },
        :showInLegend => true
      })
    end
  end
end