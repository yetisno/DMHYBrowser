$CONFIG = YAML.load(ERB.new(File.read(File.join('config', 'config.yml'))).result)

class DownloadController < ApplicationController
	def show
		@id = params[:id]
		@record = Record.find(@id)
		@record.downloaded=true
		@record.save
		File.write(File.join($CONFIG['magnet-path'], @record.id.to_s), @record.magnet)
	end
end
