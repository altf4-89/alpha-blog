class ArticlesController < ApplicationController

    before_action :article_id, only: [:show, :edit, :update, :destroy]
    def show
    end
    def index
        @articles = Article.all

    end
    def new
        @article = Article.new

    end
    def create
        @article = Article.new(ex_params)
        if @article.save
            flash[:notice] = "Article was created successfully"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end


    def edit
    end

    def update
        if @article.update(ex_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        if( @article.destroy)
            flash[:notice] = "Article was deleted successfully"
            redirect_to articles_path
        end
    end


    private

    def article_id
        begin(Article.find(params[:id]))
            @article=Article.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            flash[:alert] = "Requested Article does not exist."
            redirect_to new_article_path
        end

    end

    def ex_params
        params.require(:article).permit(:title, :description)
    end
end