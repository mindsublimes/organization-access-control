class AddMinAndMaxAgeToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :min_age, :integer
    add_column :organizations, :max_age, :integer
  end
end
