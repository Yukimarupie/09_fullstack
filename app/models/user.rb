# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    uniqueness: true.
    #すでに使用されているuser名は使用できないようにする。
    length: { maximum: 16 },
    format: {
      with: /\A[a-z0-9]+\z/,
#このwithにマッチしたものでないと許可しないようにする /\Aは行頭 \z/は行末を表す。
      message: 'は小文字英数字で入力してください'
    }

  validates :password,
    length: { minimum: 8 }
    #今回は入れないが、複雑なPASSを設定してもらいたい場合は、
    #半角英数字8文字以上100文字以下の正規表現で/\A[a-z\d]{8,100}+\z/iなどを設定したりする。
end
