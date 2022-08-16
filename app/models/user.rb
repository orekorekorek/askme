class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname

  validates :email,
    db_presence: true,
    db_uniqueness: true,
    format: { with: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :nickname,
    db_presence: true,
    db_uniqueness: true,
    format: { with: /\A\w+\z/ },
    length: { maximum: 40 }

  private

  def downcase_nickname
    nickname.downcase!
  end
end
