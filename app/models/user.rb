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

  def downcase_nickname
    nickname.downcase!
  end
end
