class Question < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  after_save_commit :update_hashtags

  validates :body, presence: true, length: { maximum: 1000 }

  scope :desc, -> { order(created_at: :desc) }
  scope :last_questions, -> { desc.first(10) }

  private

  def update_hashtags
    self.hashtags = question_hashtags.map { |hashtag| Hashtag.find_or_create_by(name: hashtag.delete('#')) }
  end

  def question_hashtags
    "#{body} #{answer}".downcase.scan(HASHTAG_REGEXP).uniq
  end
end
