class AdminDomainConstraint
  def self.matches?(request)
    Domain.exists?(host: request.host, kind: :admin)
  end
end