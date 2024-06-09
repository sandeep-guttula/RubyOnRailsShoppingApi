class CreateNames < ActiveRecord::Migration[7.2]
  def change
    create_table :names do |t|
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
  end
end
