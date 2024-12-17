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
    case type
    when :success
      'alert alert-success'
    when :error
      'alert alert-danger'
    when :warning
      'alert alert-warning'
    when :notice
      'alert alert-info'
    else
      'alert alert-secondary'
    end
  end  
end
