class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.string :title
      t.string :description
      t.string :frequency
      t.integer :times, default: 0
      t.integer :done, default: 0
      t.integer :successful, default: 0
      t.integer :unsuccessful, default: 0
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
