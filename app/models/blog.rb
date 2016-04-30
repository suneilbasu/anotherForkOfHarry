class Blog < ActiveRecord::Base
  belongs_to :user
  enum flag: [:unread, :underreview, :rejected, :redraft, :published]
  def self.all_that_are(search)
    where("flag = ?", "#{search}")
  end

  def self.search(search)
    where("user_id LIKE ?","%#{search}")
  end

  scope :published, -> {where(:flag => '4')}
end
