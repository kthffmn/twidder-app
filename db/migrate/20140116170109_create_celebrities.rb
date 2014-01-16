class CreateCelebrities < ActiveRecord::Migration
  def change
    create_table :celebrities do |t|
      t.string :name
      t.string :handle

      t.timestamps
    end
  end
end
