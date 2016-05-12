class AddStylePhotoColumnsToCakeStyles < ActiveRecord::Migration
  def change
  	add_attachment :cake_styles, :style_photo
  end
end
