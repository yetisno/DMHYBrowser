class FetchDmhyResource
	def initialize

	end

	def self.load(url = 'https://share.dmhy.org/topics/rss/rss.xml')
		begin
			url =  URI.encode URI.decode url
			xml_doc = Nokogiri::XML(open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
			xml_doc.css('rss channel item').each { |item|
				name = item.at_css(:title).content
				group = item.at_css(:author).content
				link = item.at_css(:link).content
				magnet = item.at_css(:enclosure)[:url]
				category = item.at_css(:category).content
				pub_date = DateTime.parse(item.at_css(:pubDate).content)
				category_link = item.at_css(:category)[:domain]
				category_sort_id = ''
				category_sort_id = category_link.split('/').last if category_link.empty?
				group_id = Group.find_or_create_by(name: group).id
				category_id = Category.find_or_create_by(name: category, link: category_link, sort_id: category_sort_id).id
				Record.create(name: name, group_id: group_id, link: link, pub_date: pub_date, magnet: magnet, category_id: category_id)
			}
			$logger.info('DMHY resource loaded!')
		rescue Exception => e
			$logger.error(e)
		end
	end
end
