# This proc takes a Relay global ID, and returns the Active Record model. It can be the same as
# the `object_to_id` proc that you use for global node identification:
GraphQL::Models.model_from_id = -> (id, context) {
  model_type, model_id = NodeHelpers.decode_id(id)
  model_type.find(model_id)
}

# This proc essentially reverses that process:
GraphQL::Models.id_for_model = -> (model_type_name, model_id) {
  NodeHelpers.encode_id(model_type_name, model_id)
}

# This proc is used when you're authorizing changes to a model inside of a mutator:
GraphQL::Models.authorize = -> (context, action, model) {
  # Action will be either :create, :update, or :destroy
  # Raise an exception if the action should not proceed
  user = context['user']
  model.authorize_changes!(action, user)
}

# The gem assumes that if your model is called `MyModel`, the corresponding type is `MyModelType`.
# You can override that convention. Return `nil` if the model doesn't have a GraphQL type:
GraphQL::Models.model_to_graphql_type = -> (model_class) { "#{model_class.name}Graph".safe_constantize }
