class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? or record.public?
  end

  # def edit?
  #   user.admin? or record.private?
  # end
end
