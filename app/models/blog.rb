class Blog < ActiveRecord::Base
  belongs_to :user

  scope :published, -> {where(:flag => '4')}
  scope :redraft, -> {where(:flag => '3')}
  scope :rejected, -> {where(:flag => '2')}
  scope :underreview, -> {where(:flag => '1')}
  scope :unread, -> {where(:flag => '0')}
  def self.search(search)
    where("user_id LIKE ?","%#{search}")
  end
end
