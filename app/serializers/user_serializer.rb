# frozen_string_literal: true

# class for UserSerializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
end
