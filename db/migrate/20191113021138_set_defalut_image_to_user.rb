class SetDefalutImageToUser < ActiveRecord::Migration[5.2]
  def up
    change_column_null :users, :profile_image, false, 'default.jpg'
    change_column :users, :profile_image, :string, default: 'default.jpg'
  end

  def down
    change_column_null :users, :profile_image, true, nil
  end
end
