module ItemsHelper
  extend PaginationHelper

  def item_pagination(page,limit)
    length =  SlapItem.count
   create_pagination(length,page,limit)
  end
end