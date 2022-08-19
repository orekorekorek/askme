class User < ApplicationRecord
  has_secure_password

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

  validates :header_color,
    presence: true,
    format: { with: /\A#([A-Fa-f\d]{6}|[A-Fa-f\d]{3})\z/ }

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
