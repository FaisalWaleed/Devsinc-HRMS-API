module LeavesHelper

  def get_year_leaves(user)
    user.leaves.this_year
  end

end
