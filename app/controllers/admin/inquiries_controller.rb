class Admin::InquiriesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001sd
  before_filter :authorization
  
  def index
    if params[:q].blank?
      @all_inquiries = Inquiry.all
      add_breadcrumb "Suggestions"
    else
      @all_inquiries = Inquiry.find(:all, :conditions => ["name like ? or email like ? or inquiry like ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%"])
      add_breadcrumb "Suggestions", "admin_inquiries_path"
      add_breadcrumb "Search"
    end
    @inquiries = @all_inquiries.paginate(:page => params[:page], :per_page => 50)
  end
  
  def show
    begin
      @inquiry = Inquiry.find(params[:id])
      add_breadcrumb "Suggestions", "admin_inquiries_path" 
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "That suggestion was not found."
      redirect_to admin_inquiries_path
    end
  end
  
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    respond_to :js
  end

  private
  
  
  def authorization
    authorize(@permissions['inquiries'], "Inquiries")
  end
  
end
