class MicropostController < ApplicationController
  def index
    @microposts = Micropost.all
    @count = Micropost.count
  end
end
