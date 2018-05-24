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
             :buddy_id,
             :deleted_at
  
  def name
    object.name
  end

  def manager
    object.reports_to.name
  end

end
