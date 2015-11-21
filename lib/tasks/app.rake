def alive?(pid)
	begin
		Process.getpgid(pid.to_i)
		true
	rescue
		false
	end
end

def load_conf
	require 'active_support/core_ext/string/output_safety'
	require 'yaml'
	YAML.load(ERB.new(File.read(File.join('config', 'config.yml'))).result)
end

def checkConfig
	if ENV['SECRET_KEY_BASE'].nil?
		require 'securerandom'
		secret = SecureRandom.hex(64)
		raise "config.secret_key = '#{secret}'

Please ensure you restarted your application after installing Devise or setting the key."
	end
end

namespace :app do

	desc 'Application | Start Service'
	task start: :environment do
		checkConfig
		pid = `cat unicorn.pid 2> /dev/null`
		if alive?(pid) && !pid.empty?
			puts 'Application is still running.'
		else
			puts 'Application Starting...'
			`bundle exec unicorn_rails -E production -c config/unicorn.rb -D`
			puts 'Application Started!!'
		end
	end

	desc 'Application | Stop Service'
	task stop: :environment do
		pid = `cat unicorn.pid 2> /dev/null`
		if alive?(pid) && !pid.empty?
			puts 'Application Exiting...'
			`kill -QUIT #{pid} 2> /dev/null`
			sleep 5
			puts 'Application Exited!!'
		else
			puts 'Application is not running.'
		end
	end

	desc 'Application | Restart Service'
	task restart: :environment do
		Rake::Task['app:stop'].invoke
		Rake::Task['app:start'].invoke
	end

end
