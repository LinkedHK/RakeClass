require 'active_record'

class ClientsController < ApplicationController
    extend ActiveRecord

  def demo
    @name = params[:name]
=begin

    val = rand(20)
  ActiveRecord::Base
    .connection
    .execute("insert into `schema_migrations`(version) values (#{val})")

      version =  ActiveRecord::Base
        .connection
        .execute('Select   `version` from schema_migrations limit 1')

    version.each do |row|
        row.each do |column,v|
          @name = column
        #  puts "column #{column} contains #{v}"
        end


        end

=end

  end



end