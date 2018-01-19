class WikiPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    record.public?
  end
end
