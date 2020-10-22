require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  let(:current_user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  describe '#new' do
    context "without user signed in" do 
      it "redirects to the sign in page" do 
        get :new 
        expect(response).to redirect_to(new_session_path)
      end
      it "sets a danger flash" do 
        get :new 
        expect(flash[:danger]).to be 
      end
    end

    context "with user signed in" do 
      before do 
        session[:user_id] = current_user.id 
      end

      it 'renders the new template' do 
        get :new
        expect(response).to render_template(:new)
      end
  
      it 'sets an instance variable with a new news article instance' do 
        get :new
        expect(assigns(:news_article)).to be_a_new(NewsArticle) 
      end
    end 
  end

  describe '#create' do
    context "without user signed in" do
      it "redirects to the sign in page" do 
        post :create, params: { news_article: FactoryBot.attributes_for(:news_article) }
        expect(response).to redirect_to new_session_path
      end
    end

    context "with user signed in" do 
      before do 
        session[:user_id] = current_user.id
      end
      context 'with valid parameters' do
        def valid_request
          post :create, params: {
            news_article: FactoryBot.attributes_for(:news_article)
          }
        end
  
        it 'create a new news_article in the db' do
          count_before = NewsArticle.count
          valid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before + 1)
        end
  
        it 'redirects to the show page of that news article' do
          valid_request
          expect(response).to redirect_to(news_article_path(NewsArticle.last))
        end
  
        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end
      end
  
      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            news_article: FactoryBot.attributes_for(:news_article, title: nil)
          }
        end
  
        it 'doesn\'t save a news article to the db' do
          count_before = NewsArticle.count
          invalid_request
          count_after = NewsArticle.count
          expect(count_after).to eq(count_before)
        end
  
        it 'render the new template' do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
    end

  end

  # describe "#destroy" do
  #   before do
  #     @news_article = FactoryBot.create(:news_article)
  #   end

  #   it 'removes a record from the database' do
  #     count_before = NewsArticle.count
  #     delete :destroy, params: { id: @news_article.id }
  #     count_after = NewsArticle.count
  #     expect(count_after).to eq(count_before - 1)
  #   end

  #   it 'redirects to the index page' do
  #     delete :destroy, params: { id: @news_article.id }
  #     expect(response).to redirect_to(news_articles_path)
  #   end

  #   it 'sets a flash message' do
  #     delete :destroy, params: { id: @news_article.id }
  #     expect(flash[:alert]).to be
  #   end
  # end

  describe '#show' do
    before do
      @news_article = FactoryBot.create(:news_article)
      get :show, params: { id: @news_article.id }
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'sets an instance variable based on the article id that is passed' do
      expect(assigns(:news_article)).to eq(@news_article)
    end
  end

  describe '#index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns an instance variable to all created news articles sorted by created_at' do
      news_article_1 = FactoryBot.create(:news_article)
      news_article_2 = FactoryBot.create(:news_article)
      expect(assigns(:news_articles)).to eq([news_article_2, news_article_1])
    end
  end

  describe "#edit" do
    let!(:news_article) { FactoryBot.create :news_article, user: current_user}

    context "without signed in user" do 
      it "redirects to the sgin in page" do 
        get :edit, params: { id: news_article.id }
        expect(response).to redirect_to new_session_path
      end 
    end 

    context "with signed in user" do 
      context "as owner" do 
        before do 
          request.session[:user_id] = current_user.id
          get :edit, params: { id: news_article.id }
        end
        
        it "renders the edit template" do
          get :edit, params: { id: news_article.id }
          expect(response).to render_template(:edit)
        end
    
        it "sets an instance variable based on the article id that is passed" do
          get :edit, params: { id: news_article.id }
          expect(assigns(:news_article)).to eq(news_article)
        end
      end

      context "as non owner" do 
        before do 
          request.session[:user_id] = another_user.id 
          get :edit, params: { id: news_article.id }
        end

        it "redirects to the root path" do 
          expect(response).to redirect_to root_path
        end 

        it "sets a flash message" do 
          expect(flash[:alert]).to be  
        end
      end
    end
  end

  describe "#update" do
    let(:news_article) { FactoryBot.create :news_article, user: current_user }

    context "with signed in user" do 
      context "as owner" do 
        before do
          request.session[:user_id] = current_user.id 
        end

        context 'with valid parameters' do
          it "updates the news article record with new attributes" do
            new_title = "#{news_article.title} Plus Changes!"
            patch :update, params: {id: news_article.id, news_article: {title: new_title}}
            expect(news_article.reload.title).to eq(new_title)
          end

          it "redirects to the news article show page" do
            new_title = "#{news_article.title} plus changes!"
            patch :update, params: {id: news_article.id, news_article: {title: new_title}}
            expect(response).to redirect_to(news_article)
          end
        end

        context 'with invalid parameters' do
          def invalid_request
            patch :update, params: {id: news_article.id, news_article: {title: nil}}
          end

          it "doesn't update the news article with new attributes" do
            expect { invalid_request }.not_to change { news_article.reload.title }
          end

          it "renders the edit template" do
            invalid_request
            expect(response).to render_template(:edit)
          end
        end
      end

      context "as non owner" do 
        before do 
          request.session[:user_id] = another_user.id 
          patch :update, params: { id: news_article.id, news_article: { title: "UN UPDATED TITLE"}}
        end 

        it "redirects to the root path" do 
          expect(response).to redirect_to root_path 
        end

        it "sets a flash message" do 
          expect(flash[:alert]).to be  
        end
      end
    end

  end
end
