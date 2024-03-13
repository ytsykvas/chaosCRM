# frozen_string_literal: true

class SearchEmployeeService < SearchService
  def initialize(data, visit = nil)
    super
  end

  def search(query)
    return @data if query.blank?

    terms = parse_query(query)
    results = []

    @data.each do |entry|
      relevance = calculate_relevance(entry, terms)
      results << { entry:, relevance: } if relevance.positive?
    end

    results.sort_by { |result| -result[:relevance] }.map { |item| item[:entry] }
  end

  private

  def calculate_relevance(entry, terms)
    relevance = 0

    terms.each do |term|
      relevance += 5 if entry.first_name.to_s.downcase.include?(term) ||
                        entry.last_name.to_s.downcase.include?(term) ||
                        entry.phone.to_s.include?(term)
      relevance += 3 if entry.email.to_s.downcase.include?(term)

      break if relevance.zero?
    end
    relevance
  end

  def parse_query(query)
    query.downcase.split(/\s+/).reject { |term| term[0] == '-' }
  end
end
