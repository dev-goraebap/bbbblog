class Views::Home::Index < Views::Base
  def view_template
    div(class: "text-3xl") do
      "hello world"
    end
  end
end
