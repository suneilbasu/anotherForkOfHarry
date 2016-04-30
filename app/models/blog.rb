class Blog < ActiveRecord::Base
  belongs_to :user

  enum flag: [:unread, :underreview, :rejected, :redraft, :published]
  scope :status_check, -> (flag) {where("flag like ?", "#{name}")}

  def self.search(search)
    where("user_id LIKE ?","%#{search}")
  end
end
