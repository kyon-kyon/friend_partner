class CreateSoliloquies < ActiveRecord::Migration[5.2]
  def change
    create_table :soliloquies do |t|
      t.integer :user_id
      t.string :title
      t.text :object
      t.text :what_do
      t.text :how_feel
      t.text :must_and_can
      t.text :did_action
      t.text :purpose_soliloquy

      t.timestamps
    end
  end
end
