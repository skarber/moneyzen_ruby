class Credit < ActiveRecord::Base

def create_amount(income,percent,term)
self.amount = income.to_f * (1 + percent.to_f * (term.to_f / 12))
end

def add_percent(percent)
self.percent = percent
end
end
