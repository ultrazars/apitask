class TaskSerializer < ApplicationSerializer
  attributes :title
  has_many :tags
end
