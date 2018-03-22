class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  def username
    object.user.name
  end

  def role
    Role.find(object.ticket.role_id).title
  end

  def department
    Role.find(object.ticket.role_id).department.name
  end

  def created_at
    time_ago_in_words(object.created_at) << " ago"
  end

  attributes :comment,:created_at,:username,:role,:department

end
