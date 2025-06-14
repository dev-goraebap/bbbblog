class Views::Home::Index < Views::Base
  def view_template
    div do
      "hello world!"
    end
  end
end