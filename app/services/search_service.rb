# frozen_string_literal: true

class SearchService
  def initialize(data, visit = nil)
    @data = data
    @visit = visit
  end

  def search(query)
    return @data if query.blank? && @visit.nil?

    old_last_visit if @visit == 'LastVisitOverMonth'
    no_last_visit if @visit == 'NoLastVisit'
    banned_customers if @visit == 'banned'

    terms = parse_query(query)

    results = []

    @data.each do |entry|
      relevance = calculate_relevance(entry, terms)
      results << { entry:, relevance: } if relevance.positive?
    end

    results.sort_by { |result| -result[:relevance] }.map { |item| item[:entry] }
  end

  def get_filtered_ids
    @data.map(&:id) if @data.present?
  end

  private

  def calculate_relevance(entry, terms)
    relevance = 0

    terms.each do |term|
      relevance += 5 if entry.first_name.to_s.downcase.include?(term) ||
                        entry.last_name.to_s.downcase.include?(term) ||
                        entry.phone.to_s.include?(term)
      relevance += 3 if entry.email.to_s.downcase.include?(term)
      relevance += 2 if @visit == 'NoLastVisit' && entry.last_visit.nil? ||
                        @visit == 'LastVisitOverMonth' && entry.last_visit.present? && entry.last_visit < 1.month.ago
      relevance += 1 if @visit == 'banned' && entry.banned?

      break if relevance.zero?
    end
    relevance
  end

  def parse_query(query)
    @visit.present? ? [''] : query.downcase.split(/\s+/).reject { |term| term[0] == '-' }
  end

  def old_last_visit
    @data = @data.select { |customer| customer.visited? && customer.last_visit < 1.month.ago }
  end

  def no_last_visit
    @data = @data.reject(&:visited?)
  end

  def banned_customers
    @data = @data.banned
  end
end
