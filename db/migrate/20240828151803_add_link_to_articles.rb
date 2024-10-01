class AddLinkToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :link, :string
  end
end
