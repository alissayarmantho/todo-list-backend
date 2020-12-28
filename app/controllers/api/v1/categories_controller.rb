module Api 
    module V1
        class CategoriesController < ApplicationController
            skip_before_action :verify_authenticity_token, :only => [:create, :update]
            def index
                categories = Category.order('created_at');
                render json: {status: 'SUCCESS', message: 'Loaded all Categories', data: categories}, status: :ok
            end

            def show
                #will show the todo for that category instead of showing the category
                category = Category.find(params[:id])
                todo = category.todos
                render json: {status: 'SUCCESS', message: 'Loaded a Category', data: todo}, status: :ok
            end

            def create
                category = Category.new(category_params)
                if category.save
                    render json: {status: 'SUCCESS', message: 'New Category saved', data: category}, status: :ok
                else 
                    render json: {status: 'FAILED', message: 'New Category not saved', data: category.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                category = Category.find(params[:id])
                category.destroy
                render json: {status: 'SUCCESS', message: 'Deleted Category', data: category}, status: :ok
            end

            def update
                 category = Category.find(params[:id])
                 if category.update(category_params)   
                    render json: {status: 'SUCCESS', message: 'Updated Category', data: category}, status: :ok
                 else
                    render json: {status: 'FAILED', message: 'Category not updated', data: category.errors}, status: :unprocessable_entity
                 end
            end

            private

            def category_params
                params.permit(:name)
            end
        end
    end
end