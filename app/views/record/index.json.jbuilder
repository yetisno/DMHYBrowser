json.counts @records.count
json.records @records do |record|
	json.id record.id
	json.name record.name
	json.link record.link
	json.pub_date record.pub_date
	json.group record.group.name
	# json.magnet record.magnet
	json.category record.category.name
	json.downloaded record.downloaded
end
