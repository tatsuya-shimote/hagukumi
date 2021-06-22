class AddDatesToHugs < ActiveRecord::Migration[6.0]
  def change
    add_column :hugs, :year, :integer
    add_column :hugs, :month, :integer
    add_column :hugs, :date, :integer
  end
end
