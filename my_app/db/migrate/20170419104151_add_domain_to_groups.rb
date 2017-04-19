class AddDomainToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :domain, :string
  end
end
