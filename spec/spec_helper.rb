$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'active_record'
require 'i18n_column'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table(:nodes) do |t|
      t.text(:name)
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Node < ActiveRecord::Base
  i18n_column(:name)
end
