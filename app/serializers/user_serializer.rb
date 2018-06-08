class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :company_id,
             :contact_number,
             :secondary_contact_number,
             :emergency_contact_person_name,
             :emergency_contact_person_number,
             :emergency_contact_person_relation,
             :dob,
             :permanent_address,
             :temporary_address,
             :bank_account_number,
             :employment_history,
             :performance_evaluation,
             :image,
             :reporting_to,
             :name,
             :join_date,
             :title,
             :manager,
             :team_members,
             :buddy_id,
             :deleted_at

  def image
    object.image.url ? "http://localhost:3000#{object.image&.url.to_s}" : "http://www.copypanthers.com/wp-content/uploads/2015/07/avatars__Jorn.png"
  end

  def name
    object.name
  end

  def manager
    {
        id: object.reporting_to,
        name: object.reports_to.name,
        image: object.reports_to.image.url ? "http://localhost:3000#{object.reports_to.image&.url.to_s}" : "http://www.copypanthers.com/wp-content/uploads/2015/07/avatars__Jorn.png"
    }
  end

  def team_members
    object.team_members
  end

end
