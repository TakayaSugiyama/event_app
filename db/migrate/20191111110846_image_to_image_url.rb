class ImageToImageUrl < ActiveRecord::Migration[5.2]
   add_column :users, :profile_image, :string
end
