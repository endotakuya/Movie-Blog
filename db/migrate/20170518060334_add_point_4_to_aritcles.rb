class AddPoint4ToAritcles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :point_4, :integer
  end
end
