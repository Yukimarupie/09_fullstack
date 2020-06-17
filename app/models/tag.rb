# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :board_tag_relations, dependent: :delete_all
#一つのタグが複数のboard_tag_relationを持つことを意味する
#このdelete_allが有効なのは、deleteメソッドではなくdestroyメソッドなため、boards_controller.rbなどを修正する
  has_many :boards, through: :board_tag_relations
#一つのタグが複数の掲示板を持つことを意味する。ポイントはthroughで、中間テーブルであるboard_tag_relationsを経由して掲示板と関連づけるための設定

end
