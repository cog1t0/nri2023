class User < ApplicationRecord
    belongs_to :icon
    belongs_to :event
    belongs_to :group, optional: true
    
    validates :name1, presence: true
    # TODO: ニックネームか二つ名かが確定したら、validationを設定。今なname1のみを必須にしている
    # validates :name2, presence: true
    validates :line_id, presence: true
    validates :from, presence: true, if: -> { to.present? }
    validates :to, presence: true, if: -> { from.present? }
end
