# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee::Operation::Show do
  let!(:admin_user) { create(:user, account_type: 'admin') }
  let(:employee) { create(:user, account_type: 'employee') }
  let(:valid_params) { ActionController::Parameters.new({ id: employee.id }) }

  subject { described_class.new }

  before do
    allow_any_instance_of(described_class).to receive(:authorize!).and_return(nil)
  end

  describe '#perform!' do
    it 'returns the employee with today visits and visits without conclusion' do
      today_visits = create_list(:visit, 3, employee: employee, visit_date: Time.zone.today)
      create_list(:visit, 5, employee: employee, conclusion: nil)

      subject.perform!(user: admin_user, params: valid_params)

      expect(subject.result.model[:employee]).to eq(employee)
      expect(subject.result.model[:visits][:today_visits].size).to eq(3)
      expect(subject.result.model[:visits][:without_conclusion].size).to eq(5)
    end

    it 'returns the employee with no visits without conclusion when there are no visits without conclusion' do
      today_visits = create_list(:visit, 3, employee: employee, visit_date: Time.zone.today)

      subject.perform!(user: admin_user, params: valid_params)

      expect(subject.result.model[:employee]).to eq(employee)
      expect(subject.result.model[:visits][:today_visits].size).to eq(3)
      expect(subject.result.model[:visits][:without_conclusion].size).to eq(0)
    end

    it 'returns the employee with no today visits when there are no today visits' do
      create_list(:visit, 5, employee: employee, conclusion: nil)

      subject.perform!(user: admin_user, params: valid_params)

      expect(subject.result.model[:employee]).to eq(employee)
      expect(subject.result.model[:visits][:today_visits].size).to eq(0)
      expect(subject.result.model[:visits][:without_conclusion].size).to eq(5)
    end
  end
end
