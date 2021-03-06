module Api 
    module V1
        class TodosController < ApplicationController
            skip_before_action :verify_authenticity_token, :only => [:create, :update]
            def index
                vars = request.query_parameters
                if vars['categoryid'] != nil
                    queried_category = vars['categoryid']
                    todos = Todo.where(category_id: queried_category)
                    render :json => todos, status: :ok
                else
                    todos = Todo.order('created_at');
                    render :json => todos, status: :ok
                end
                rescue StandardError => e
                    render json: {
                    error: e.to_s
                    }, status: :internal_server_error
            end

            def show
                todo = Todo.find(params[:id])
                render :json => todo, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            def create
                todo = Todo.new(todo_params)
                puts todo
                if todo.save
                    render json: {message: 'Todo Content saved', data: todo}, status: :ok
                else 
                    render json: {message: 'Todo Content not saved', data: todo.errors}, status: :unprocessable_entity
                end
                rescue StandardError => e
                    render json: {
                    error: e.to_s
                    }, status: :internal_server_error
            end

            def destroy
                todo = Todo.find(params[:id])
                todo.destroy
                render json: {message: 'Deleted Todo', data: todo}, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            def update
                 todo = Todo.find(params[:id])
                 if todo.update(todo_params)   
                    render json: {message: 'Updated Todo', data: todo}, status: :ok
                 else
                    render json: {message: 'Todo Content not updated', data: todo.errors}, status: :unprocessable_entity
                 end
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            private

            def todo_params
                params.permit(:content, :category_id)
            end
        end
    end
end