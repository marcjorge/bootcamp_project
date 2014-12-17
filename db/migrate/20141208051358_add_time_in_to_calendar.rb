class AddTimeInToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :time_in, :string
  end
end
