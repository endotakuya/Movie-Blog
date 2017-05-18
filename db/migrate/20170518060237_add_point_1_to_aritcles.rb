class AddPoint1ToAritcles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :point_1, :integer
  end
end
