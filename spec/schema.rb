ActiveRecord::Schema.define :version => 0 do
  create_table :model_to_sanitizes, :force => true do |t|
    t.column :name, :string
    t.column :description, :text
  end
end
