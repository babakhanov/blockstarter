class StubsController < ActionController::Base
  def show
    @path = params[:path].split("/")
    if @path[0] == "tpl"
      render "stubs/#{@path.drop(1).join("/")}", layout: false
    else
      render "stubs/#{params[:path]}", :layout => 'stubs'
    end
  end
end

