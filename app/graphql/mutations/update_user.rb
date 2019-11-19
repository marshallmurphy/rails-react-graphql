class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :email, String, required: false

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(id:, name:)
    user = User.find(id)
    if user.update(name: name)
      {
        user: user,
        errors: [],
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end


# Query to update user
#
# mutation {
#   updateUser(input: {
#     id: 1,
#     name: "Tyler Murphy",
#     email: "test@test.com"
#   }) {
#     user {
#       id
#       name
#       email
#     }
#     errors
#   }
# }
