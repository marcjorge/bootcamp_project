class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :holiday_date
      t.string :holiday_name
      t.string :holiday_type

      t.timestamps
    end
  end
end
