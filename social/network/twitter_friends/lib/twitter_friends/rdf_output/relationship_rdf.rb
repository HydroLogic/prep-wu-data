module TwitterFriends::StructModel

  module RelationshipCommon
    def rdf_resource
      @rdf_resource ||= rdf_component(user_a_id, :user)
    end
  end

  AFollowsB.class_eval do
    include TwitterFriends::TwitterRdf
    def to_rdf3_tuples
      [
        [rdf_component(user_b_id, :user), rdf_pred(:follows), rdf_component(user_b_id, :user)]
      ]
    end
  end

  ARepliesB.class_eval do
    include TwitterFriends::TwitterRdf
    def to_rdf3_tuples
      [
        [rdf_component(user_b_id, :user), rdf_pred(:replied_to), rdf_component(user_b_id, :user), rdf_component(status_id, :tweet) ]
      ]
    end
  end

  AAtsignsB.class_eval do
    include TwitterFriends::TwitterRdf
    def to_rdf3_tuples
      [
        [rdf_component(user_b_id, :user), rdf_pred(:atsigns), rdf_component(user_b_name, :user)]
      ]
    end
  end

end
