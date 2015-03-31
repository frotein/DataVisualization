class CreateDataMatrices < ActiveRecord::Migration
  def change
    create_table :data_matrices do |t|

      t.timestamps
    end
  end
end
