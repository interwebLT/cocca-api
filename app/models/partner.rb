class Partner < ActiveRecord::Base
  alias_attribute :username, :name
end
