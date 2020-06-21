# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#age' do
    #Time.zoneのオブジェクトでnowメソッドが呼ばれた場合、Time.zoneで4/1のオブジェクトを返すように設定している。
    before do
       allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2020/04/01'))
    end

    context '20年前の生年月日の場合' do
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      it '年齢が20際であること' do
        expect(user.age).to eq 20
      end
    end
  
  
  
#誕生日当日の場合
    context '10年前に生まれた場合で、ちょうど誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2010/04/01')) }

      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

#誕生日がまだ来ていなければ9歳であることをテストできる
    context '10年前に生まれた場合で、誕生日が来ていない場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2010/04/02')) }

      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end

  end
end
