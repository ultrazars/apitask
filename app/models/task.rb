class Task < ApplicationRecord
  validates :title, presence: true

  has_and_belongs_to_many :tags

  def set_tags(tags)
    replacement_tags = []
    transaction do
      tags.each do |title|
        replacement_tags << Tag.where(title: title).first_or_create!
      end
      self.tag_ids = replacement_tags.map(&:id)
    end
  end
end
