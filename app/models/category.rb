class Category < ApplicationRecord
  belongs_to :tree
  belongs_to :node
end
