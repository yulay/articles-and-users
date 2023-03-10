class ArticlesController < ApplicationController
    #refactoriza el codigo y hace que @article = Article.find(params[:id]) solamente se ejecute a 
    #traves del metodo set_article y al usarse con show edit destroy update
    # puede emplear only (solo en esos) o except (en todos menos en estos)
    before_action :set_article, only: %i[show edit destroy update]
    before_action :categories_ids, only: %i[create update]

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def show
        #Debemos conocer el articulo que vamos a mostrar, para eso usamos el find
        
        @comment = Comment.new
    end

    def edit
        #Debemos conocer el articulo que vamos a editar, para eso usamos el find
        
    end

    def destroy
        #Debemos conocer el articulo que vamos a eliminar, para eso usamos el find
        
        @article.destroy
        redirect_to articles_path
    end

    def update
        #Debemos conocer el articulo que vamos a actualizar, para eso usamos el find

        Article.update_categories(@article, categories_ids) if categories_ids.present?

        if @article.update(article_params)
            redirect_to article_path(@article), notice: "Article was updated."
        else
            render :edit, status: :unprocessable_entity
        end

        # @article.update(article_params)
        # redirect_to article_path(@article)
    end

    def create
        # comentada por la refactorizacion con params
        # @article = Article.new(name: params[:article][:name], description: params[:article][:description])
        # Cambiada por lo siguiente
        # Estas dos lineas se pueden hacer como la unica de abajo
        # @article = Article.new(article_params)
        # @article.user_id = current_user.id
        # se pueden hacer asi
        @article = current_user.articles.build(article_params)

        Article.add_categories(@article, categories_ids) if categories_ids.present?

        if @article.save
            redirect_to articles_path, notice: "Article was created."
        else
            render :new, status: :unprocessable_entity
        end

        # @article.save
        # redirect_to articles_path
    end

    #para refactorizar los parametros en rails

    private

    def article_params
        params.require(:article).permit(:name, :description, :avatar, :body)
    end

    def categories_ids
        params[:categories][:ids].reject{|i| i.empty? }
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
