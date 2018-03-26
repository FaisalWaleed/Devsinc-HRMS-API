class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  def username
    object.user.name
  end

  def role
    current_user.roles.first.title
  end

  def department
    current_user.roles.first.department.name
  end

  def created_at
    time_ago_in_words(object.created_at) << " ago"
  end

  attributes :comment,:created_at,:username,:role,:department,:ticket_id

end
