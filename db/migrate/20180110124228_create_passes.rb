class CreatePasses < ActiveRecord::Migration[5.1]
  def change
    create_table :passes, id: false, primary_key: :key do |t|
      t.string :pass
      t.string :key

      t.timestamps
    end
  end
end
