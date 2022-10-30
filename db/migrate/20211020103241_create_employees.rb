class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.references       :department,                null: false
      t.references       :office,                    null: false
      t.string           :number,                    null: false
      t.string           :last_name,                 null: false
      t.string           :first_name,                null: false
      t.string           :account,                   null: false
      t.string           :password,                  null: false
      t.string           :email,                     null: false
      t.date             :date_of_joining,           null: false
      t.boolean          :employee_info_manage_auth, null: false,  default: false
      t.boolean          :new_posting_auth, null: false,  default: false
      t.datetime         :deleted_at,                null: true,   default: nil

      t.timestamps
    end
    add_foreign_key :employees, :departments
    add_foreign_key :employees, :offices
  end
end
