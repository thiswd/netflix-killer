module Pagination
  extend ActiveSupport::Concern

  DEFAULT_PER_PAGE = 25.freeze
  ALL_PER_PAGE = "all".freeze

  def page_num
    params.fetch(:page, 1).to_i
  end

  def per_page
    params.fetch(:per_page, DEFAULT_PER_PAGE).to_i
  end

  def all?
    params[:per_page] == ALL_PER_PAGE
  end

  def paginate_offset
    (page_num - 1) * per_page
  end

  def order_by
    params.fetch(:order_by, :id)
  end

  def order_direction
    params.fetch(:order_direction, :asc)
  end

  def paginate
    ->(records) do
      records = records.limit(per_page).offset(paginate_offset) unless all?
      records.order("#{order_by}": order_direction)
    end
  end
end
