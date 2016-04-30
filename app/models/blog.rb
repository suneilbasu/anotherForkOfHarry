class Blog < ActiveRecord::Base
  belongs_to :user

  enum flag: [:unread, :underreview, :rejected, :redraft, :published]
  scope :flaged, -> {where(:flag => '0')}
  scope :status_check, -> (flag){where(:flag => flag)}

  def self.search(search)
    where("user_id LIKE ?","%#{search}")
  end
end
