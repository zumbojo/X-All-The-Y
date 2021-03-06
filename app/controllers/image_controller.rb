class ImageController < ApplicationController
  def show
    # words!
    @words = params[:words].gsub('.',' ').split('/')
    @first_line = @words[0]
    @second_line = @words[1]

    case request.subdomains.first
    when 'fry'
      render_standard("#{RAILS_ROOT}/public/images/fry.png", '')
    when 'goodguy'
      render_standard("#{RAILS_ROOT}/public/images/goodguy.png", '')
    when 'rockso'
      render_standard("#{RAILS_ROOT}/public/images/rockso_shhh.png", '')
    when 'scumbag'
      render_standard("#{RAILS_ROOT}/public/images/scumbag.png", '')
    when 'yuno'
      render_standard("#{RAILS_ROOT}/public/images/yuno.png", '?')
    else
      render_hyperbole
    end
  end

  private 
    def render_standard(filename, append)
      @first_line << append unless @second_line

      image = Magick::Image.read(filename).first
      overlay = Magick::Draw.new
      overlay.annotate(image, 0, 0, 0, 10, @first_line.upcase) {
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
      if @second_line
        overlay.annotate(image, 0, 0, 0, 10, @second_line.upcase << append) {
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

    def render_hyperbole
      # pictures!
      #
      # basic .annotate examples at 
      # http://rmagick.rubyforge.org/portfolio.html
      if sad?
        @first_line << '?' unless @second_line

        image = Magick::Image.read("#{RAILS_ROOT}/public/images/sad.png").first
        overlay = Magick::Draw.new
        overlay.annotate(image, 0, 0, 0, 10, @first_line.downcase) {
            self.gravity = Magick::NorthGravity
            self.pointsize = 60
            self.fill = 'black'
            self.font_family = "Impact"
        }
        if @second_line
          overlay.annotate(image, 0, 0, 0, 10, @second_line.downcase << '?') {
              self.gravity = Magick::SouthGravity
              self.pointsize = 60
              self.fill = 'black'
              self.font_family = "Impact"
          }
        end
      else
        @first_line << '!' unless @second_line

        image = Magick::Image.read("#{RAILS_ROOT}/public/images/responsible.png").first
        overlay = Magick::Draw.new
        overlay.annotate(image, 0, 0, 0, 10, @first_line.upcase) {
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
        if @second_line
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
      end

      # output!
      response.headers["Content-Type"] = "image/png"
      render :text => image.to_blob
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
