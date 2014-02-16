# encoding: utf-8
class TodoApi::V1::List < Grape::API

  resource :lists do

    # Require authentication
    before { authenticated? } 

    ## INDEX
    desc 'Returns current user lists', {
      entity: Entity::List,
      notes: 'Get all lists for authenticated user.'
    }
    get do
      lists = current_user.lists
      present lists, with: Entity::List
    end

    ## CREATE
    desc "Create new list", {
      entity: Entity::List,
      notes: 'Create new list for authenticated user'
    }
    params do
      requires :title, type: String, desc: "Title"
    end
    post do
      list = current_user.lists.build(title: params[:title])
      if list.save
        present list, with: Entity::List
      else
        error! list.errors
      end
    end

    ## PUT
    desc "Edit list"
    params do
      requires :_id, type: String, desc: "Identification"
      requires :title, type: String, desc: "Title"
    end
    put do
      list = current_user.lists.find(params[:_id])
      if list
        list.update({
          title: params[:title]
        })
      else
        error! list.errors
      end
    end

    ## DELETE
    desc "Delete list"
    params do
      requires :_id, type: String, desc: "Identification"
    end
    delete do
      list = current_user.lists.find(params[:_id])
      list.destroy
      "Success"
    end
  end
end