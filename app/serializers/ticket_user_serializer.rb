class TicketUserSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  def created_at
    time_ago_in_words(object.created_at) << " ago"
  end

  def status
    object.ticket_status.active.status
  end

  def username
    User.find(object.user_id).name
  end

  attributes :ticket_id,:user_id,:username,:status,:created_at

end
