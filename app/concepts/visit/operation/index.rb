# frozen_string_literal: true

class Visit::Operation::Index < Operation::Base
  def perform!(user:, params:, **)
    authorize!(:visits, :index?)

    user_with_visits = User.find(params[:id])
    if user_with_visits.admin? || user_with_visits.employee?
      all_visits = user_with_visits.visits_as_employee
    elsif user_with_visits.visitor?
      all_visits = user_with_visits.visits_as_customer
    end

    self.model = {
      user:,
      user_with_visits:,
      all_visits: all_visits.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    }
  end
end
