class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:username,:email,:image,:company_id
end
