class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.references :user, foreign_key: true
    end
  end
end
