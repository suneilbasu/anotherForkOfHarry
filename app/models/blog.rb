class Blog < ActiveRecord::Base
  belongs_to :user

  enum flag: [:unread, :underreview, :rejected, :redraft, :published]
  scope :status,    ->  (flag) {where flag: flag}
  scope :keyword,   ->  (keyword)   {where("bodyText like ?","%#{keyword}%")}
  scope :blog,      ->  (blog)      {where user_id: blog}
  scope :published, ->              {where(:flag => '4')}
end
