class CreateProfilesTable < ActiveRecord::Migration
  def change
	  create_table :profiles do |t|
		  t.string :username
		  t.string :email
		  t.string :fname
		  t.string :lname
		  t.integer :user_id #foreign key
	end
  end
end
