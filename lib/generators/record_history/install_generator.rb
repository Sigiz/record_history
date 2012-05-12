require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

module RecordHistory
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates (but does not run) a migration to add a versions table.'

    def create_migration_file
      %w/create_record_histories alter_record_histories_add_transaction_id/.each do |f|
        begin
          migration_template "#{f}.rb", "db/migrate/#{f}.rb"
        rescue Rails::Generators::Error => e
          puts e.message
        end
      end
    end
  end
end
