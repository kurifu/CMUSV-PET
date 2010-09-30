require 'active_record/fixtures'

class LoadLifecycleData1 < ActiveRecord::Migration
  def self.up
    down

    directory = File.join(File.dirname(__FILE__), 'dev_data')
    Fixtures.create_fixtures(directory, "lifecycles")
  end

  def self.down
    Lifecycle.delete_all
  end
end
