class WikiPolicy < ApplicationPolicy
  
  def new?
    user.present?
  end

  def create?
    new?
  end

  def show?
    true
  end

  def edit?
    destroy?
  end

  def destroy?
    user.admin? || record.user == user
  end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
