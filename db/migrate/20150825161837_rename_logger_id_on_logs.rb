class RenameLoggerIdOnLogs < ActiveRecord::Migration
  def change
    rename_column :logs, :logger_id, :staff_id
  end
end
