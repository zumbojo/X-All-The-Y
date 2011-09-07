class ImageController < ApplicationController
  def show
    # words!
    @words = params[:words].gsub('.',' ').split('/')
    @first_line = @words.shift
    @second_line = @words.shift

    # pictures!
    #
    # basic .annotate examples at 
    # http://rmagick.rubyforge.org/portfolio.html
    if sad?
      image = Magick::Image.read("#{RAILS_ROOT}/public/images/sad.png").first
      overlay = Magick::Draw.new
      overlay.annotate(image, 0, 0, 0, 10, @first_line.downcase << '?') {
          self.gravity = Magick::NorthGravity
          self.pointsize = 60
          self.fill = 'black'
          self.font_family = "Impact"
      }
      overlay.annotate(image, 0, 0, 0, 10, @second_line.downcase << '?') {
          self.gravity = Magick::SouthGravity
          self.pointsize = 60
          self.fill = 'black'
          self.font_family = "Impact"
      }
    else
      image = Magick::Image.read("#{RAILS_ROOT}/public/images/responsible.png").first
      overlay = Magick::Draw.new
      overlay.annotate(image, 0, 0, 0, 10, @first_line.upcase << '!') {
          self.gravity = Magick::NorthGravity
          self.pointsize = 60
          self.fill = 'white'
          # lolcat text spec:
          # http://news.deviantart.com/article/41903/
          self.font_family = "Impact"
          self.stroke = 'black'
          self.stroke_width = 2
          self.font_weight = Magick::BoldWeight
      }
      overlay.annotate(image, 0, 0, 0, 10, @second_line.upcase << '!') {
          self.gravity = Magick::SouthGravity
          self.pointsize = 60
          self.fill = 'white'
          # lolcat text spec:
          # http://news.deviantart.com/article/41903/
          self.font_family = "Impact"
          self.stroke = 'black'
          self.stroke_width = 2
          self.font_weight = Magick::BoldWeight
      }
    end

    # output!
    response.headers["Content-Type"] = "image/png"
    render :text => image.to_blob
  end

  private 
    def show_error_message
      # todo
      # image should be prerendered and static
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
