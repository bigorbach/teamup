class CreateUserSets < ActiveRecord::Migration[5.0]
  def change
    create_table :user_sets do |t|

      t.string :topic, null: false
      t.integer :team_size, null: false
      t.boolean :balance, default: false
      t.string :skill, default: false

      t.timestamps

    end
  end
end
