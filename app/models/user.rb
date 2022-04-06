class User < ApplicationRecord
  # validates :first_name, :last_name, format: { with: /[А-Я]+[а-яА-Я]{2,}/ }

  scope :first_name_more, -> (len) { where('length(first_name) > :len', len: len) }
  scope :last_name_less, -> (len) { where('length(last_name) < :len', len: len) }
  scope :by_name_len, -> (f_len, l_len) { first_name_more(f_len).last_name_less(l_len) }

  has_many :orders
  has_one :passport_data
end
