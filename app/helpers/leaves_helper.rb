module LeavesHelper

  def get_year_leaves(user)
    year_leaves_count = 0
    user.leaves.this_year.each do |leave|
      year_leaves_count += ( (leave.end_date - leave.start_date).to_i + 1 )
    end
    year_leaves_count
  end

  def get_month_leaves(user)
    month_leaves_count = 0
    user.leaves.this_month.each do |leave|
      month_leaves_count += ( (leave.end_date - leave.start_date).to_i + 1)
    end
    month_leaves_count
  end

end
