class FileUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_upload, only: [:destroy, :share]

  def index
    @file_uploads = current_user.file_uploads
  end

  def new
    @file_upload = FileUpload.new
  end

  def create
    @file_upload = current_user.file_uploads.new(file_upload_params)
    if @file_upload.save
      redirect_to file_uploads_path, notice: "File uploaded successfully"
    else
      render :new
    end
  end

  def destroy
    @file_upload.destroy
    redirect_to file_uploads_path, notice:  "File deleted successfully"
  end

  def share
    @file_upload = current_user.file_uploads.find(params[:id])
    @file_upload.generate_public_token unless @file_upload.public_token.present?

    respond_to do |format|
      format.json { render json: { public_url: public_file_url(@file_upload.public_token) } }
      format.html { redirect_to file_uploads_path, success: "File shared publicly! Public URL: #{public_file_url(@file_upload.public_token)}" }
    end
  end

  def public_show
    @file_upload = FileUpload.find_by(public_token: params[:token])
    if @file_upload&.file&.attached?
      redirect_to rails_blob_path(@file_upload.file, disposition: "inline")
    else
      render plain: "Invalid or expired link", status: :not_found
    end
  end

  private

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:id])
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file)
  end
end
