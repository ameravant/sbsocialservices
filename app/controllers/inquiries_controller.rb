class InquiriesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  #add_breadcrumb "Home", "root_path"
  before_filter :find_page, :except => :index
  before_filter :find_user, :only => [:new, :create]

  def new
    @inquiry = Inquiry.new
    add_breadcrumb @page.name, nil    
  end
  
  def index
    @page = Page.find_by_permalink!('suggestions_received')
    if params[:q].blank?
      @all_inquiries = Inquiry.all
      add_breadcrumb "Suggestions Received"
    else
      @all_inquiries = Inquiry.find(:all, :conditions => ["name like ? or email like ? or inquiry like ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%"])
      add_breadcrumb "Suggestions Received", suggestions_received_path
      add_breadcrumb "Search"
    end
    @inquiries = @all_inquiries.paginate(:page => params[:page], :per_page => 25)
  end
  
  def show
    @inquiry = Inquiry.find(params[:id])
    @owner = @inquiry
  end
  
  def create
    params[:person][:email].blank? ? params[:inquiry][:email] = "none_provided" : params[:inquiry][:email] = params[:person][:email]
    params[:person][:name].blank? ? params[:inquiry][:name] = "none_provided" : params[:inquiry][:name] = params[:person][:name]
    @inquiry = Inquiry.new(params[:inquiry])
    if !@inquiry.save
      render :action => "new"
    else
    @inquiry_page = Page.find_by_permalink!('suggestions')
    @page = Page.find_by_permalink!('suggestions_received') # used in create view
    add_breadcrumb @inquiry_page.name, "/#{@inquiry_page.permalink}"
    add_breadcrumb "Thank you for your suggestion."
    redirect_to('/suggestions_received')
    end
  end

  def find_user
    @user = current_user
  end

  def find_page
    @page = Page.find_by_permalink!('suggestions')
    # @article_categories = ArticleCategory.active
    # @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
    # @article_authors = Person.active.find(:all, :conditions => "articles_count > 0")
    # @article_tags = Article.published.tag_counts.sort_by(&:name)
  end

end

