class CreatePaybackPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :payback_points do |t|
      t.integer :point
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
