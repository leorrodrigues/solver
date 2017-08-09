class Node < ApplicationRecord
  belongs_to :category
  has_many :children
end
