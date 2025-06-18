class Views::Lab::ImageUploads::Item < Views::Base
  def initialize(test_object:)
    @test_object = test_object
  end

  def view_template
    a(
      href: "/lab/image-uploads/#{@test_object.id}",
      class: "flex flex-col gap-4 bg-base-100 p-4 border border-neutral/50"
    ) do
      p(class: "text-2xl") do
        plain "##{@test_object.name}"
      end
      
      div(class: "flex gap-2") do
        @test_object.images.each do |image|
          render Views::Partials::Image.new(
            url: helpers.url_for(image),
            dominant_color: image.blob.metadata["dominant_color"],
            width: "w-36",
            height: "h-36",
            alt: @test_object.name
          )
        end
      end
    end
  end
end