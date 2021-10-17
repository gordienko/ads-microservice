# frozen_string_literal: true

module RequestHelpers
  def response_body
    JSON(response.body)
  end
end
