module Api 
    module V1
        class TodosController < ApplicationController
            skip_before_action :verify_authenticity_token, :only => [:create, :update]
            def index
                todos = Todo.order('created_at');
                render json: {status: 'SUCCESS', message: 'Loaded all Todo Content', data: todos}, status: :ok
            end

            def show
                todo = Todo.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded Todo Content', data: todo}, status: :ok
            end

            def create
                todo = Todo.new(todo_params)
                puts todo
                if todo.save
                    render json: {status: 'SUCCESS', message: 'Todo Content saved', data: todo}, status: :ok
                else 
                    render json: {status: 'FAILED', message: 'Todo Content not saved', data: todo.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                todo = Todo.find(params[:id])
                todo.destroy
                render json: {status: 'SUCCESS', message: 'Deleted Todo', data: todo}, status: :ok
            end

            def update
                 todo = Todo.find(params[:id])
                 if todo.update(todo_params)   
                    render json: {status: 'SUCCESS', message: 'Updated Todo', data: todo}, status: :ok
                 else
                    render json: {status: 'FAILED', message: 'Todo Content not updated', data: todo.errors}, status: :unprocessable_entity
                 end
            end

            private

            def todo_params
                params.permit(:content, :category_id)
            end
        end
    end
end