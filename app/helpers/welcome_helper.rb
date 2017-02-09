module WelcomeHelper
  def application_name
    Rails.application.name.gsub(/_/,' ').upcase
  end
  def format_date(string)
    l(string.to_date, format: :date_month_year)
  end
end
