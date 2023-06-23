class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :employee_id, limit: 10
      t.string :name, limit: 400
      t.boolean :active
      t.boolean :developer
      t.timestamps
    end
  end
end
