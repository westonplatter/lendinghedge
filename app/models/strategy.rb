class Strategy < ActiveRecord::Base
  belongs_to :user

  resourcify
  acts_as_paranoid

  def short_name
    self.name.truncate(25)
  end
end
