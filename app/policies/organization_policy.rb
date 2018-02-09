class OrganizationPolicy < ApplicationPolicy

  class Scope < ApplicationScope
    def resolve
      user.organization
    end
  end

  def name?
    user.present? && user.organization_id == record.id
  end

  def update?
    # TODO: check if user is admin
    true #user.present? && user.organization_id == organization.id
  end
end
