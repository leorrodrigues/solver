class Node < ApplicationRecord
    has_many :children
    has_many :categories
end
