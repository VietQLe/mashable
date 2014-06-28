require 'sinatra'
require 'rest_client'

#call mashable api and returns json as a string
	resp = RestClient.get('http://mashable.com/stories.json?new_per_page=100')
	#turns string into a hash
	doc = JSON.parse(resp)

get '/' do 
	#grabbing new array from the mashable json and storing it in instance variable stories
	@stories = doc['new']	
	#creating new array channels to store channel types
	channels = Array.new
	@stories.each do |story|
		channels << story['channel']
	end
	#creating instance array to eliminate duplicates of channels
	@channels = channels.uniq.sort
	#creating new array to store authors
	authors = Array.new
	@stories.each do |story|
		authors << story['author']
	end
	#creating instance array to eliminate duplicates of authors
	@authors = authors.uniq.sort
	erb :home
end

get '/category/:category' do |category|
	all_stories = doc['new']

	channels = Array.new
	all_stories.each do |story|
		channels << story['channel']
	end
	
	@channels = channels.uniq.sort

	authors = Array.new
	all_stories.each do |story|
		authors << story['author']
	end

	@authors = authors.uniq.sort

	@stories = []
	all_stories.each do |story|
		if story['channel'] == category
			@stories << story
		end
	end

	@selected = category
	erb :home
end

get '/authors/:author' do |author|
	all_stories = doc['new']

	channels = Array.new
	all_stories.each do |story|
		channels << story['channel']
	end
	
	@channels = channels.uniq.sort

	authors = Array.new
	all_stories.each do |story|
		authors << story['author']
	end

	@authors = authors.uniq.sort

	@stories = []
	all_stories.each do |story|
		if story['author'] == author
			@stories << story
		end
	end
	
	@selected = author
	erb :home
end
