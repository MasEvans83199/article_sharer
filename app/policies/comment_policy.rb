class CommentPolicy < ApplicationPolicy
  def update?
    user_is_admin_or_moderator? || user_is_owner?
  end

  def destroy?
    update?
  end

  private

  def user_is_admin_or_moderator?
    user.present? && (user.has_role?(:admin) || user.has_role?(:moderator))
  end

  def user_is_owner?
    user.present? && user == record.user
  end
end
