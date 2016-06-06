class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :email_address
      t.string :email_type
      t.string :event
      t.integer :timestamp

      t.timestamps null: false
    end

    # add_index :email_type
    # add_index :event
  end
end
