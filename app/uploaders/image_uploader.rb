# frozen_string_literal: true

class ImageUploader < Shrine
  IMAGE_MIME_TYPES = %w[image/jpeg image/png].freeze

  Attacher.validate do
    validate_mime_type IMAGE_MIME_TYPES
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      small: magick.resize_to_fill!(260, 150),
      large: magick.resize_to_fill!(1090, 400)
    }
  end
end
