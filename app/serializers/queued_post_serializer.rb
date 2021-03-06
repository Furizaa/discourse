class QueuedPostSerializer < ApplicationSerializer

  attributes :id,
             :queue,
             :user_id,
             :state,
             :topic_id,
             :approved_by_id,
             :rejected_by_id,
             :raw,
             :post_options,
             :created_at,
             :category_id

  has_one :user, serializer: BasicUserSerializer, embed: :object
  has_one :topic, serializer: BasicTopicSerializer

  def category_id
    cat_id = object.topic.try(:category_id) || object.post_options['category']
    cat_id.to_i if cat_id
  end

  def include_category_id?
    category_id.present?
  end

end
