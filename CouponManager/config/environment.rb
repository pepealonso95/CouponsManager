# Load the Rails application.
require_relative 'application'


# file = File.open("log/#{Rails.env}-logs.log", File::WRONLY | File::APPEND )
# logger = Logger.new('foo.log', 'daily')
# Rails.logger = Logger.new(STDOUT, 'daily')
# config.logger = ActiveSupport::Logger.new("log/#{Rails.env}-logs.log")
# Initialize the Rails application.
Rails.application.initialize!



