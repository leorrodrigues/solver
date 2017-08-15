class Cloud < ApplicationRecord
    validates_presence_of :vm,:cpu,:ram,:storage
end
