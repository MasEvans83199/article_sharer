require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new(body: 'This is a body.')
    assert_not article.save, "Saved the article without a title"
  end

  test "should save article with title and body" do
    article = Article.new(title: 'Test Title', body: 'This is a body.')
    assert article.save, "Couldn't save the article with all attributes"
  end
end
