class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :titile
      t.text :body
      t.string :user_id
      t.string :post_id

      t.timestamps
    end
  end
end
