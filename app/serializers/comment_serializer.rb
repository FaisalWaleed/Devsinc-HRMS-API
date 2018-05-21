class CommentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  def username
    object.user.first_name + object.user.last_name
  end

  def role
    User.find(object.user_id).roles.first.title
  end

  def department
    User.find(object.user_id).roles.first.department.name
  end

  def created_at
    time_ago_in_words(object.created_at) << " ago"
  end

  attributes :comment,:created_at,:username,:role,:department,:ticket_id

end
