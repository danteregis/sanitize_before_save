ActiveRecord::Schema.define :version => 0 do
  create_table :sanitize_models, :force => true do |t|
    t.column :name, :string
    t.column :description, :text
    t.column :count, :integer
  end
  
  
  create_table :sanitize_with_except_option_models, :force => true do |t|
    t.column :name, :string
    t.column :description, :text
  end
end
