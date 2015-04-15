class JsonUrlController < ApplicationController
	require 'json'
	require 'open-uri'
	require 'matrix'

  def new
  	@input = ""
    @checks = [params[:a], params[:b],params[:c],params[:d],params[:e],params[:f],params[:g] ]
    @names = DataMatrix.getNames() 
    @rows = DataMatrix.getData()
    @from  = params[:from]
    @to = params[:to]
    @subAr = [1,2]
    m2 = @rows
    
    
    @mat = Matrix[*m2]
    @colArray = [1, 3, 5]
    i = 0
     @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Comparing Player Attributes")

      f.xAxis(:categories => [ 1 , 2, 3, 4, 5])
      
      f.yAxis [
        {:title => {:text => "Player Attributes Comparison", :margin => 70} }
             ]
      
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end
  
  end

  def show
    @input = ""
    @subAr = [1,2]
    @checks = [params[:a], params[:b],params[:c],params[:d],params[:e],params[:f],params[:g] ]
    @from  = params[:from]
    @to = params[:to]
    @rows = DataMatrix.getData()
    @names = DataMatrix.getNames() 
    @colArray = [1, 3, 5]
    m2 = @rows  

    @csv = Hash[]

    @mat = Matrix[*m2]
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title(:text => params[:l])
    to = @to.to_i()
    from = @from.to_i()
    f.xAxis(:categories => [ to , to + 1, to + 2, to + 3, to + 4,to + 5, to + 6, to + 7, to + 8,to + 9,to + 10,to + 11, to + 12, to + 13, to + 14,to + 15, to + 16, to + 17, to + 18])
    
    @len =  to - from 
    
    @checks.each_with_index do |c,index|
      
      @colArray = @mat.column(index).to_a()
      @subAr = @colArray.slice(from,@len)
      if c != nil
        f.series(:name => c, :yAxis => 0, :data => @subAr)
        @csv[c] = @subAr
      end
    end
          
    f.yAxis [
      {:title => {:text => "Player Attributes Comparison", :margin => 70} }
           ]

    f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
    f.chart({:defaultSeriesType=>"column"})
    end
  end

end