$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))
plugin_test_dir = File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'rspec-set'
require 'logger'
require 'factory_girl'
require 'faker'

require 'active_support'
require 'active_model'
require 'active_record'
require 'shoulda-matchers'

require 'record_history'

ActiveRecord::Base.logger = Logger.new(plugin_test_dir + "/debug.log")

require 'yaml'
require 'erb'
ActiveRecord::Base.configurations = YAML::load(ERB.new(IO.read(plugin_test_dir + "/db/database.yml")).result)
ActiveRecord::Base.establish_connection(ENV["DB"] || "sqlite3mem")
ActiveRecord::Migration.verbose = false
load(File.join(plugin_test_dir, "db", "schema.rb"))

require 'support/models'

RSpec.configure do |config|
  config.after do
    [SomeData, User, RecordHistoryModel].each(&:destroy_all)
    FactoryGirl.reload
  end
end
