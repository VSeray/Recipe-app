class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.decimal :cooking_time
      t.decimal :preparation_time
      t.string :description
      t.boolean :public, default: false

      t.timestamps
    end
  end
end
