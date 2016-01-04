class OrderDetail
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :type, :domain, :period

  validates :type,    presence: true
  validates :domain,  presence: true, format: { with: /\./ }
  validates :period,  presence: true, numericality: { less_than_or_equal_to: 10 }
end
