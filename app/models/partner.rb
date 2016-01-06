class Partner < ActiveRecord::Base
  alias_attribute :username, :name

  validates :name,  presence: true
end
