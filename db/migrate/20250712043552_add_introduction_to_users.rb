class AddIntroductionToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :introduction, :string
  end
end
