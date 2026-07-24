class UniversityDomainConstraint
  def self.matches?(request)
    Domain.exists?(host: request.host, kind: :university)
  end
end