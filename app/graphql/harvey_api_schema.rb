HarveyApiSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Set up the graphql-batch gem
  lazy_resolve(Promise, :sync)
  instrument(:query, GraphQL::Batch::Setup)

  # Set up the graphql-activerecord gem
   instrument(:field, GraphQL::Models::Instrumentation.new)
end
