class Views::Partials::Image < Views::Base
  def initialize(url:, dominant_color: "#f0f0f0", width: "w-full", height: "h-full", alt: "")
    @url = url
    @dominant_color = dominant_color
    @width = width
    @height = height
    @alt = alt
  end

  def view_template
    div(
      data: { controller: "image-loader", image_loader_target: "container" },
      class: "relative overflow-hidden transition-colors duration-700 #{@width} #{@height}",
      style: "background-color: #{@dominant_color};"
    ) do
      img(
        data: { image_loader_target: "image" },
        src: @url,
        loading: "lazy",
        class: "w-full h-full object-cover transition-opacity duration-500 opacity-0",
        alt: @alt
      )
    end
  end
end
