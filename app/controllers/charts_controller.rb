# encoding: utf-8

class ChartsController < ApplicationController

  def charts
	@graph = LazyHighCharts::HighChart.new('column') do |f|
		f.series(:name=>'Correct',:data=> [1, 2, 3, 4, 5])
		f.series(:name=>'Incorrect',:data=> [10, 2, 3, 1, 4] )       
		f.title({ :text=>"clickable bar chart"})
		f.legend({:align => 'right', 
	        :x => -100, 
	        :verticalAlign=>'top',
	        :y=>20,
	        :floating=>"true",
	        :backgroundColor=>'#FFFFFF',
	        :borderColor=>'#CCC',
	        :borderWidth=>1,
	        :shadow=>"false"
        })
		f.options[:chart][:defaultSeriesType] = "column"
		f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Time"}, :categories => ["1.1.2011", "2.1.2011", "3.1.2011", "4.1.2011", "5.1.2011"]}
		f.options[:yAxis][:title] = {:text=>"Answers"}
		f.options[:plot_options][:column] = {:stacking=>'normal', 
		  :cursor => 'pointer',
		  :point => {:events => {:click => js_function}}
		}  
	end
end
