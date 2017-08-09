class Category < ApplicationRecord
  belongs_to :tree
  has_many :alternatives
  has_many :nodes
end
