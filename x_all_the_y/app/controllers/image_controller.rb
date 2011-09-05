class ImageController < ApplicationController
  def show
    @verb = params[:words].split('/').first
    @noun = params[:words].split('/').last
    render :text => "#{@verb} all the #{@noun}" 

    # todo: spaces via dots
  end

  private 
    def show_error_message
      # todo
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
