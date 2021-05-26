# frozen_string_literal: true

class BlogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(author_id: user['id'])
    end
  end

  def create?
    owner?
  end

  def show?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    user['id'] == record.author_id
  end
end
