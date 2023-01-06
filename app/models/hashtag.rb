class Hashtag < ApplicationRecord
  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  validates :name, db_presence: true, db_uniqueness: true

  scope :with_questions, -> { where_exists(:question_hashtags) }
  scope :desc, -> { order(created_at: :desc) }

  def to_param
    name
  end
end
