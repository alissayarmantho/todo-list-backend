module Api 
    module V1
        class CategoriesController < ApplicationController
            skip_before_action :verify_authenticity_token, :only => [:create, :update]
            def index
                categories = Category.order('created_at');
                render :json => categories, status: :ok
                rescue StandardError => e
                    render json: {
                    error: e.to_s
                    }, status: :internal_server_error
            end

            def show
                category = Category.find(params[:id])
                render :json => category, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            def create
                category = Category.new(category_params)
                if category.save
                    render json: {message: 'New Category saved', data: category}, status: :ok
                else 
                    render json: {message: 'New Category not saved', data: category.errors}, status: :unprocessable_entity
                end
                rescue StandardError => e
                    render json: {
                    error: e.to_s
                    }, status: :internal_server_error
            end

            def destroy
                category = Category.find(params[:id])
                category.destroy
                render json: {message: 'Deleted Category', data: category}, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            def update
                 category = Category.find(params[:id])
                 if category.update(category_params)   
                    render json: {message: 'Updated Category', data: category}, status: :ok
                 else
                    render json: {message: 'Category not updated', data: category.errors}, status: :unprocessable_entity
                 end
                rescue ActiveRecord::RecordNotFound => e
                    render json: {
                    error: e.to_s
                    }, status: :not_found
            end

            private

            def category_params
                params.permit(:name)
            end
        end
    end
end