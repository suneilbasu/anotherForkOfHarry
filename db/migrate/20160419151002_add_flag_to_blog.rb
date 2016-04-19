class AddFlagToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :flag, :integer, default: 0
  end
end
