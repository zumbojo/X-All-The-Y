class ImageController < ApplicationController
  def show
    @words = params[:words].gsub('.',' ').split('/')
    @verb = @words.shift
    @noun = @words.pop

    if @words.length == 0
      render :text => "#{@verb} all the #{@noun}" 
    else
      render :text => "#{@verb} #{@words} #{@noun}" 
    end
  end

  private 
    def show_error_message
      # todo
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
