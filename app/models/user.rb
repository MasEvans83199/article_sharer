class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy

  before_save :sync_roles_with_boolean_fields

  def admin?
    has_role?(:admin)
  end

  def moderator?
    has_role?(:moderator)
  end

  private

  def sync_roles_with_boolean_fields
    if admin_changed?
      admin ? add_role(:admin) : remove_role(:admin)
    end

    if moderator_changed?
      moderator ? add_role(:moderator) : remove_role(:moderator)
    end
  end
end
