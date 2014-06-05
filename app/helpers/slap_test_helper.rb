module SlapTestHelper
  require 'slap_item'
  def create_pagination(page,limit)
   page  < 1 ? page = 1 : page

   num_pages =  (SlapItem.count/limit).ceil

        if SlapItem.count % limit != 0
        num_pages += 1
        else

        end



   num_links = 3
   start_pgn = 1
   end_pgn = 1



content_tag(:ul,:class => "pagination")   do

  if num_pages <= 1
    return
  end

  if num_links > num_pages
    start_pgn = 1
    end_pgn = num_pages
  end
  if page > 1
    calc = page-1
    concat(print_li_a(calc,"«",[]))
  end
  if page < num_links
    start_pgn = 1
    end_pgn = num_links
  else
         if num_pages>num_links
           concat(print_li_a(1,1,[]))
         end
    if page > num_links
      draw_dotes
    end
    calc =  (num_links/2).floor
    start_pgn = page-calc
    end_pgn = page+calc

    if start_pgn < 1
      end_pgn +=  start_pgn.abs+1
      start_pgn = 1
    end
    if end_pgn > num_pages
      start_pgn -= (end_pgn-num_pages)
      end_pgn = num_pages
    end

  end

  (start_pgn..end_pgn).each  do |i|

    if i > num_pages
      break
    end
    if i == page
      concat(print_li_a(i,i,["active"]))
    else
      concat(print_li_a(i,i,[]))
    end
  end

  if end_pgn < num_pages
    draw_dotes
  end

  if page < num_pages-1 && num_pages>num_links
    concat(print_li_a(page+1,"»",[]))
    concat(print_li_a(num_pages,num_pages,[]))
  end



    end

  end

  def print_li_a(ref,capt,attr)
    content_tag(:li, :class => attr.join(" ")) do
      link_to capt, slap_pagination_path(:pg => ref),class: attr.join(" ")
    end

  end
  def hello_world(name)
    "hello #{name}"
  end

  def draw_dotes
    concat(
        content_tag(:li) do
          content_tag(:a) do
            " .... "
          end

        end
    )
  end
  def draw_back(page)
    concat(print_li_a(page,"«",[]))
  end

  def draw_next(page)
    concat(print_li_a(page+1,"»",[]))
  end



end
