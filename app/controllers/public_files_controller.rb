class PublicFilesController < ApplicationController
  def show
    @file_upload = FileUpload.find_by(public_token: params[:token])
    if @file_upload.present?
      # Show a page with file details and download link
    else
      render plain: "File not found", status: :not_found
    end
  end

  def download
    @file_upload = FileUpload.find_by(public_token: params[:token])
    if @file_upload.present? && @file_upload.file.attached?
      # Redirect to the actual file URL
      redirect_to rails_blob_path(@file_upload.file, disposition: "attachment")
    else
      render plain: "File not found", status: :not_found
    end
  end
end
