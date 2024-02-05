Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5500", "https://goal-tracker-izm1.onrender.com"
    resource "*",
      headers: :any,
      credentials: true,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
