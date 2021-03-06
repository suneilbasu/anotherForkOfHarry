class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :blogs
  enum role: [:journalist, :editor]
 after_initialize :set_default_role, :if => :new_record?

 def set_default_role
   self.role ||= :journalist
 end

 # Include default devise modules. Others available are:
 # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
