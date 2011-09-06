class ImageController < ApplicationController
  def show
    # words!
    @words = params[:words].gsub('.',' ').split('/')
    @verb = @words.shift
    @noun = @words.pop

    @text = @words.length == 0 ? "#{@verb} all the #{@noun}" :
      "#{@verb} #{@words} #{@noun}" 
    
    # pictures!
    image = Magick::Image.read("#{RAILS_ROOT}/public/images/responsible.png").first

    # http://rmagick.rubyforge.org/portfolio.html
    overlay = Magick::Draw.new
    # todo: use sad? and handle all differences in two different
    #  annotate blocks
    overlay.annotate(image, 0, 0, 0, 60, @text) {
        self.gravity = Magick::SouthGravity
        self.pointsize = 48
        self.stroke = 'transparent'
        self.fill = '#0000A9'
        self.font_weight = Magick::BoldWeight
        }

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
