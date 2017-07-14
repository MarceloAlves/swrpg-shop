# == Schema Information
#
# Table name: source_books
#
#  id         :integer          not null, primary key
#  key        :string           not null
#  title      :string           not null
#  collection :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SourceBook < ApplicationRecord
  validates :key, :title, presence: true
end
