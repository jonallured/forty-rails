class RelaxMinuteColumns < ActiveRecord::Migration[6.0]
  def change
    columns = %i[adjust_minutes in_minutes out_minutes pto_minutes]

    columns.each do |column|
      change_column_null :work_days, column, from: false, to: true
      change_column_default :work_days, column, from: 0, to: nil
    end
  end
end
