class AddPoint2ToAritcles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :point_2, :integer
  end
end
