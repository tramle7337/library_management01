class Admin::AuthorsController < AdminController
  before_action :load_author, except: %i(new create index)

  def index
    @authors = Author.alphabet.search_author(params[:search])
      ._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @authors.to_xsl}
    end
  end

  def new
    @author = Author.new
  end

  def edit; end

  def update
    if @author.update_attributes author_params
      flash[:success] = t ".updated"
      redirect_to @author
    else
      render :edit
    end
  end

  def show; end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t ".success"
      redirect_to @author
    else
      render :new
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to admin_authors_path
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t ".error"
    redirect_to admin_authors_path
  end

  def author_params
    params.require(:author).permit :name, :profile, :picture
  end
end
