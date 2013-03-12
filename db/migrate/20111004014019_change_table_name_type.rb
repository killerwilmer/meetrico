class ChangeTableNameType < ActiveRecord::Migration
  def self.up
    change_table :tables do |t|
      t.change :name, :string
    end
  end

  def self.down
    change_table :tables do |t|
      t.change :name, :integer
    end
  end
end
