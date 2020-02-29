class CreateExamples < ActiveRecord::Migration[6.0]
  def change
    create_table :examples do |t|
      t.string :name, default: 'name example'
    end
  end
end
