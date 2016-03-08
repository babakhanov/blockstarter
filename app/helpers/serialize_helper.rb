module SerializeHelper
  def serialize_objects(objects, serializer, options = {})
    options = options.merge({ each_serializer: serializer })
    ActiveModel::ArraySerializer.new(objects, options)
  end

  def serialize_object(object, serializer = nil)
    serializer ||= [object.class.name, 'Serializer'].join().constantize

    serializer.new(object).as_json(
      root: false,
      user: current_user
    )
  end
end
