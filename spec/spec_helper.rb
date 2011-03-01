require('i18n_column')

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

ActiveRecord::Schema.define(:version => 1) do
  create_table(:nodes) do |t|
    t.string(:name)
  end
end

class Node < ActiveRecord::Base
  i18n_column(:name)
end
