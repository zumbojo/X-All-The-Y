class ImageController < ApplicationController
# def show
#   @words = params[:words].gsub('.',' ').split('/')
#   @verb = @words.shift
#   @noun = @words.pop

#   if @words.length == 0
#     render :text => "#{@verb} all the #{@noun}" 
#   else
#     render :text => "#{@verb} #{@words} #{@noun}" 
#   end
# end
  
  def show
    response.headers["Content-Type"] = "image/png"
    image = Magick::Image.read("#{RAILS_ROOT}/public/images/responsible.png").first


    # http://rmagick.rubyforge.org/portfolio.html
    text = Magick::Draw.new
    text.annotate(image, 0, 0, 0, 60, "My friend!") {
        self.gravity = Magick::SouthGravity
        self.pointsize = 48
        self.stroke = 'transparent'
        self.fill = '#0000A9'
        self.font_weight = Magick::BoldWeight
        }
    render :text => image.to_blob
  end

  private 
    def show_error_message
      # todo
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
