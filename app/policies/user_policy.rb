class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    true
  end

  def new?
    user.nil? || user.admin?
  end

  def create?
    new?
  end

  def edit?
    user.admin? || record == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end