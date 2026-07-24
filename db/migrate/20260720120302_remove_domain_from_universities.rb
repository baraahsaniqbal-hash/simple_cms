class RemoveDomainFromUniversities < ActiveRecord::Migration[6.1]
  def change
    remove_column :universities, :domain, :string
  end
end
