class GitHubService
  attr_reader :name,
              :commits_and_names,
              :pulls

  def initialize
    @name ||= get_repo_name
    @commits_and_names = get_repo_commits_and_names
    @pulls ||= get_repo_pulls
  end

  def conn
    Faraday.new('https://api.github.com') do |req|
      req.headers['Authorization'] = "token #{ENV['github_api_key']}"
    end
  end

  def get_repo_name
    resp = conn.get('/repos/joeyh92989/little-esty-shop')
    parsed = JSON.parse(resp.body, symbolize_names: true)
    name = parsed[:name]
  end

  def get_repo_commits_and_names
    resp = conn.get('/repos/joeyh92989/little-esty-shop/stats/contributors')

    parsed = JSON.parse(resp.body, symbolize_names: true)
    names = []

    contributor_information = parsed.each_with_object({}) do |login, total|
      total[login[:author][:login]] = login[:total]
    end

  end

  def get_repo_pulls
    resp = conn.get('repos/joeyh92989/little-esty-shop/pulls?state=all')

    JSON.parse(resp.body, symbolize_names: true).count
  end
end
