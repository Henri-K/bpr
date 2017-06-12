class EnableUuidExtension < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp' # => http://theworkaround.com/2015/06/12/using-uuids-in-rails.html#postgresql
  end
end
