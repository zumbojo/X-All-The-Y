class ImageController < ApplicationController
  def show
    # words!
    @words = params[:words].gsub('.',' ').split('/')
    @verb = @words.shift
    @noun = @words.pop

    @text = @words.length == 0 ? "#{@verb} all the #{@noun}" :
      "#{@verb} #{@words} #{@noun}" 
    
    # pictures!
    #
    # basic .annotate examples at 
    # http://rmagick.rubyforge.org/portfolio.html
    if sad?
      image = Magick::Image.read("#{RAILS_ROOT}/public/images/sad.png").first
      overlay = Magick::Draw.new
      overlay.annotate(image, 0, 0, 0, 10, @text.downcase << '?') {
          self.gravity = Magick::NorthGravity
          self.pointsize = 60
          self.fill = 'black'
          self.font_family = "Impact"
      }
    else
      image = Magick::Image.read("#{RAILS_ROOT}/public/images/responsible.png").first
      overlay = Magick::Draw.new
      overlay.annotate(image, 0, 0, 0, 10, @text.upcase << '!') {
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
