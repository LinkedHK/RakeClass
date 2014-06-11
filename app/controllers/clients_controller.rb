require 'active_record'

class ClientsController < ApplicationController
    extend ActiveRecord

  def demo
    @name = params[:name]
  end



end