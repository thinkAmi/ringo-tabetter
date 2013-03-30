class Apple < ActiveRecord::Base

  scope :count_apple,
    select('count(name) as amount, name')
    .group('name')
    .order('amount DESC')

  scope :count_apple_monthly,
    select("name, to_char(tweeted_at, 'MM') as month, count(name) as amount")
    .group('name, month')
    .order('name, month')

end
