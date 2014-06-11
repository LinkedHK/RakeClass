class SlapItem < ActiveRecord::Base
  validates  :item_title,:item_description, presence: true
  validates_length_of :item_title , :maximum => 255
  validates_length_of :item_description,   :maximum => 2500

  def self.gen_pagination(page,limit)
    page ||= 1
    @items_number = SlapItem.count
    @calc =   (page-1) * limit
    @offset = page > 0 ? @calc : 0
    @item = SlapItem.select([:item_title,:item_description,:id]).limit(limit).offset(@offset)
    return @item
  end

  def self.recent_items(past_date)


  end
end
