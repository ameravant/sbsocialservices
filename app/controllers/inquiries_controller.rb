class InquiriesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  #add_breadcrumb "Home", "root_path"
  before_filter :find_page

  def new
    @inquiry = Inquiry.new
    add_breadcrumb @page.name, nil    
  end
  
  def index
    @inquiries = Inquiry.all
  end
  
  def show
    @inquiry = Inquiry.find(params[:id])
    @owner = @inquiry
  end
  
  def create
    params[:inquiry][:email] = "noreply"
    params[:inquiry][:name] ||= "not provided"
    @inquiry = Inquiry.new(params[:inquiry])
    if !@inquiry.save
      render :action => "new"
    else
      @inquiry_page = Page.find_by_permalink!('suggestions')
      @page = Page.find_by_permalink!('suggestion_confirm') # used in create view
      add_breadcrumb @inquiry_page.name, "/#{@inquiry_page.permalink}"
      add_breadcrumb "Thank you for your suggestion."
    end
  end

  def find_page
    @page = Page.find_by_permalink!('suggestions')
    # @article_categories = ArticleCategory.active
    # @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
    # @article_authors = Person.active.find(:all, :conditions => "articles_count > 0")
    # @article_tags = Article.published.tag_counts.sort_by(&:name)
  end

end

