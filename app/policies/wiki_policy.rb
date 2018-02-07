class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    create?
    # user.admin? or record.user == user
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  # def edit?
  #   user.admin? or record.private?
  # end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end
end
