class Apple < ActiveRecord::Base

  scope :count_apple,
    select('count(name) as amount, name, name as dummy_for_color')
    .group('name')
    .order('amount DESC')


end
