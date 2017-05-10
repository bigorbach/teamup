class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|

      t.string :name, null: false
      t.string :skill_strength

      t.belongs_to :user
      t.belongs_to :user_set
      # t.belongs_to :team

      t.timestamps

    end
  end
end
