
class ApplicationController < ActionController::Base
  before_action :footer

  def footer
    @github_service = GitHubService.new
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
