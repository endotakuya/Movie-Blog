class AddPoint5ToAritcles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :point_5, :integer
  end
end
