class LabController < ApplicationController
  def modal_test
    render "lab/modal_test"
  end

  def modal_content
    render "lab/modal_test/content", layout: "modal"
  end
end
