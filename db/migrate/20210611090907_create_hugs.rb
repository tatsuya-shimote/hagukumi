class CreateHugs < ActiveRecord::Migration[6.0]
  def change
    create_table :hugs do |t|
      t.references :user, foreign_key: true
      t.integer :count
      t.integer :time

      t.timestamps
    end
  end
end
