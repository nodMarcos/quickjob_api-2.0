class ServiceSearch < Search
  def self.from_params(params)
    @services_search = new(
      query: "*",
      per_page: params[:per_page],
      sort_filters: { _score: :desc }
    )

    @services_search = @services_search.by_service_category(params[:service_category_name]) if params[:service_category_name].present?

    @services_search
  end

  def model_class
    Service
  end

  def by_service_category(service_category)
    where_filters[:service_category_name] = service_category
    self
  end
end