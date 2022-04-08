class Vm < ApplicationRecord
  has_many :hdds
  has_and_belongs_to_many :projects
end
