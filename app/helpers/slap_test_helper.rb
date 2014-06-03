module SlapTestHelper
  require 'slap_item'
  def create_pagination(page,limit)

   @pagination_limit = 2
   @elemts_per = 5

   @page  <= 0 ? page = 1 : page

   @total = SlapItem.count/@elemts_per
     content_tag(:ul,:class => "pagination")   do
       (0..@pagination_limit-1).each do |i|
         if page > @pagination_limit-1 && i == 0


           concat(
               content_tag(:li) do
                 link_to "«", slap_pagination_path(:pg => page-1)
               end
             )
         end
         @calc = page+i
         if @calc > @total
           break
         end
         concat(
             content_tag(:li) do
               link_to @calc, slap_pagination_path(:pg => @calc)
             end
         )
           if page+1 < @total && i == @pagination_limit-1
             concat(
                 content_tag(:li) do
                   link_to "»", slap_pagination_path(:pg => @calc+1)
                 end
             )
           end

       end

     end

  end
  def hello_world(name)
    "hello #{name}"
  end
end
