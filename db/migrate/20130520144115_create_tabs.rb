class CreateTabs < ActiveRecord::Migration
  def self.up
    create_table :tabs do |t|
      t.string :name, null: false, default: "My FanGate Tab"
      t.string :description
      t.timestamps
    end

  end

  def self.down
    drop_table :tabs
  end
end
