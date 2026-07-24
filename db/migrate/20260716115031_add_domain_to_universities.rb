class AddDomainToUniversities < ActiveRecord::Migration[6.1]
  def change
    add_column :universities, :domain, :string
  end
end
