class AddDescriptionColumnToCakeStyles < ActiveRecord::Migration
  def change
  	add_column("cake_styles", "description", :text)
  end
end
