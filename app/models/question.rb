class Question < ApplicationRecord
  after_save_commit :update_hashtags

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :body, presence: true, length: { maximum: 1000 }

  def update_hashtags
    self.hashtags = question_hashtags.map { |hashtag| Hashtag.find_or_create_by(name: hashtag.delete('#')) }
  end

  def question_hashtags
    "#{body} #{answer}".downcase.scan(/#[[:word:]-]+/).uniq
  end
end
