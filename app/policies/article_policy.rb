# app/policies/article_policy.rb
class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.has_role?(:admin) || user == article.user  # Admins can edit any post, others can edit their own
  end

  def destroy?
    user.has_role?(:admin) || user.has_role?(:moderator) || user == article.user  # Admins and moderators can delete any post, others can delete their own
  end

  class Scope < Scope
    def resolve
      scope.all 
    end
  end  
end
