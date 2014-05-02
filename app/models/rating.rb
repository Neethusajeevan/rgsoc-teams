class Rating < ActiveRecord::Base
  class << self
    def user_names
      User.find(pluck(:user_id).uniq).map(&:name)
    end

    def excluding(names)
      joins(:user).where('users.name NOT IN (?)', names)
    end

    def by(user)
      where(user: user)
    end
  end

  serialize :data

  belongs_to :application
  belongs_to :user

  def data
    Hashr.new(super)
  end

  def value
    data.values.sum
  end
end