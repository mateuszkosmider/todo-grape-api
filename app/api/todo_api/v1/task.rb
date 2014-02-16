# encoding: utf-8
class TodoApi::V1::Task < Grape::API

  resource :tasks do

    # Require authentication
    before { authenticated? } 

    ## INDEX
    desc 'Returns current user tasks', {
      entity: Entity::Task,
      notes: 'Get all tasks for list.'
    }
    params do
      requires :list_id, type: String, desc: 'List ID'
    end
    get ':list_id' do
      tasks = current_user.lists.find(params[:list_id]).tasks
      present tasks, with: Entity::Task
    end

    ## CREATE
    desc 'Create new task', {
      entity: Entity::Task,
      notes: 'Create new task'
    }
    params do
      requires :list_id, type: String, desc: 'List ID'
      requires :title, type: String, desc: 'New task title'
      optional :complete, type: Boolean, desc: 'Is completed', default: false
    end
    post ':list_id' do
      list = current_user.lists.find(params[:list_id])
      task = list.tasks.build(title: params[:title], complete: params[:complete])
      if task.save
        present task, with: Entity::Task
      else
        error! task.errors
      end
    end

    ## PUT 
    desc "Mark completed task", {
      entity: Entity::Task,
      notes: 'mark as complete'
    }
    params do
      requires :list_id, type: String, desc: "List ID"
      requires :_id, type: String, desc: "Task ID"
      optional :title, type: String, desc: "Task title"
      optional :complete, type: Boolean, desc: "Complete"
    end
    put ':list_id' do
      task = current_user.lists.find(params[:list_id]).tasks.find(params[:_id])
      if task
        task.update({
          title: params[:title],
          complete: params[:complete]
        })
      else
        error! list.errors
      end
    end

    ## DELETE
    desc "Delete task", {
      entity: Entity::Task,
      notes: 'Delete task'
    }
    params do
      requires :list_id, type: String, desc: "List ID"
      requires :_id, type: String, desc: "Task ID"
    end
    delete ':list_id' do
      task = current_user.lists.find(params[:list_id]).tasks.find(params[:_id])
      task.destroy
      "Success"
    end
  end
end