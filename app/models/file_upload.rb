class FileUpload < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  before_save :set_file_type

  validate :file_size_validation

  private

  def set_file_type
    if file.attached?
      blob = file.blob
      file_extension = File.extname(blob.filename.to_s).downcase
      self.file_type = file_extension
    end
  end

  def file_size_validation
    return unless file.attached?

    if file.blob.byte_size > 1.gigabyte
      errors.add(:file, "size must be less than or equal to 1 GB")
      file.purge # Remove the file to prevent saving it
    end
  end
end
