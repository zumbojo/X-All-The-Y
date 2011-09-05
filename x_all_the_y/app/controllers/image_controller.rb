class ImageController < ApplicationController
  def show
    @verb = params[:words].split('/').first.gsub('.',' ')
    @noun = params[:words].split('/').last.gsub('.',' ')
    render :text => "#{@verb} all the #{@noun}" 
  end

  private 
    def show_error_message
      # todo
    end

    def sad?
      /\?/.match(request.request_uri) != nil
    end
end
