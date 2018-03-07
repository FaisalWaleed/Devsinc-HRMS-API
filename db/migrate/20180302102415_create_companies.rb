class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :custom_domain , index: true, unique: true
      t.string :subdomain , index: true, unique: true, null: false

      t.timestamps
    end



  end
end
