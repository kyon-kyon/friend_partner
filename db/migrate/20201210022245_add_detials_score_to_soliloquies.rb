class AddDetialsScoreToSoliloquies < ActiveRecord::Migration[5.2]
  def change
    add_column :soliloquies, :title_score, :decimal, precision: 5, scale: 3
    add_column :soliloquies, :what_do_score, :decimal, precision: 5, scale: 3
    add_column :soliloquies, :how_feel_score, :decimal, precision: 5, scale: 3
    add_column :soliloquies, :must_and_can_score, :decimal, precision: 5, scale: 3
    add_column :soliloquies, :did_action_score, :decimal, precision: 5, scale: 3
    add_column :soliloquies, :porpose_soliloquy_score, :decimal, precision: 5, scale: 3
  end
end
