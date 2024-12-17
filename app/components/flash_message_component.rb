# frozen_string_literal: true

class FlashMessageComponent < ViewComponent::Base
  include ApplicationHelper
  attr_reader :type, :message

  def initialize(type:, message:)
    @type = type
    @message = message
  end
  
  private

  def color_classes
    color_map = {
      success: 'alert alert-success',
      error: 'alert alert-danger',
      warning: 'alert alert-warning',
      notice: 'alert alert-info',
      alert: 'alert alert-warning'
    }
  
    color_map[type] || 'alert alert-secondary'
  end 
end
