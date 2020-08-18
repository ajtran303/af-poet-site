class Admin::AboutController < Admin::BaseController
  def index
    @about = About.first
  end

  def edit
    @about = About.first
  end

  def update
    About.first.update(about_params)
    redirect_to admin_about_index_path
  end

  private

  def about_params
    params.require(:about).permit(:description)
  end
end
