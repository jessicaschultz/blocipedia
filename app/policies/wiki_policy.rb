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
  #   user.admin? or record.public?
  # end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        #if user is admin, show all wikis
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki || wiki.owner == user || wiki.collaborators.include?(user)
            # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
            wikis << wiki
          end
        end
      else #standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis #returns all the wikis array built
    end
  end
end
