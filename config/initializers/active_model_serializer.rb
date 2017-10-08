ActiveModel::Serializer.config.adapter = :json_api
ActiveModelSerializers.config.key_transform = :underscore

ActiveModelSerializers.config.jsonapi_include_toplevel_object = true
