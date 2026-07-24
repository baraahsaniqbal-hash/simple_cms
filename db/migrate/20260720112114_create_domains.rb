class CreateDomains < ActiveRecord::Migration[6.1]
  def change
    create_table :domains do |t|
      t.string :host
      t.integer :kind
      t.references :university, null: true, foreign_key: true

      t.timestamps
    end
  end
end
