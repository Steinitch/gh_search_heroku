class HttpRequest

  include HTTParty

  attr_accessor :query

  def initialize(query)
    @query = query
  end

  def search_github
    HTTParty.get("https://api.github.com/search/repositories?q=#{query}&sort=stars&order=desc&per_page=15")
  end

end
