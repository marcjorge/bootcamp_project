class AddTimeOutToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :time_out, :string
  end
end
