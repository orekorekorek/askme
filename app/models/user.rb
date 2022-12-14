class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :delete_all

  before_validation :downcase_nickname

  validates :email,
            db_presence: true,
            db_uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :nickname,
            db_presence: true,
            db_uniqueness: true,
            format: { with: /\A\w+\z/ },
            length: { maximum: 40 }

  validates :name,
            db_presence: true

  validates :header_color,
            presence: true,
            format: { with: /\A#([A-Fa-f\d]{6}|[A-Fa-f\d]{3})\z/ }

  scope :desc, -> { order(created_at: :desc) }
  scope :last_users, -> { desc.first(10) }

  def to_param
    nickname
  end

  include Gravtastic
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
