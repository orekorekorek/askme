class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :nickname,
    presence: true,
    uniqueness: true,
    format: { with: /\A\w+\z/, message: " can contain only Latin letters, numbers, and a sign _" },
    length: { maximum: 40 }

  validates :header_color,
    presence: true,
    format: { with: /\A#([A-Fa-f\d]{6}|[A-Fa-f\d]{3})\z/ }

  def downcase_nickname
    nickname.downcase!
  end
end
