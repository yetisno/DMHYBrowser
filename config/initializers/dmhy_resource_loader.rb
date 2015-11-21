require 'open-uri'
require 'nokogiri'
require 'rufus-scheduler'
require_relative '../../lib/fetch_dmhy_resource'

$scheduler = Rufus::Scheduler.new
$logger = Rails.logger

def circle_fetch_dmhy_resource
	$scheduler.every '1m' do
		FetchDmhyResource.load
	end
end

circle_fetch_dmhy_resource
