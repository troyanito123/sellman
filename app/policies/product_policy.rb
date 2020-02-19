class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    !user.nil?
  end

  def create?
    new?
  end

  def edit?
     user.admin? || user == record.user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end