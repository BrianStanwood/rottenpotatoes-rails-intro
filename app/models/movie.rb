class Movie < ActiveRecord::Base
  def get_rating
    self.rating
  end
end
