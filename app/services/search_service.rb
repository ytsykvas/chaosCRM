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
      relevance += 2 if entry.email.to_s.downcase.include?(term)
      relevance += 1 if @visit == 'NoLastVisit' && entry.last_visit.nil?
      relevance += 1 if @visit == 'LastVisitOverMonth' && entry.last_visit.present? && entry.last_visit < 1.month.ago

      break if relevance.zero?
    end
    relevance
  end

  def parse_query(query)
    @visit.present? ? [''] : query.downcase.split(/\s+/).reject { |term| term[0] == '-' }
  end

  def old_last_visit
    @data = @data.where('last_visit < ?', 1.month.ago)
  end

  def no_last_visit
    @data = @data.where(last_visit: nil)
  end
end
