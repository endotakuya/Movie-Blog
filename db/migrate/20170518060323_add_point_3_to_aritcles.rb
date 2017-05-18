class AddPoint3ToAritcles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :point_3, :integer
  end
end
