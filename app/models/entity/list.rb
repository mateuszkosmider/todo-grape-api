# encoding: utf-8
module Entity
  class List < Base
    expose :_id, documentation: {type: "string", desc: "BSON id"}, format_with: :to_string

    expose :title, documentation: {type: "string", desc: "List title"}

    with_options(format_with: :iso_timestamp) do
      expose :created_at, documentation: {type: "DateTime", desc: "List created at "}
      expose :updated_at, documentation: {type: "DateTime", desc: "List updated at "}
    end
  end
end