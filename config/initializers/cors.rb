Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '*', 
        headers: :any, 
        methods: [:get, :post], 
        expose: ['Authorization'],
        max_age: 600,
        credentials: true,
        :if => development { |env| env['CONTENT_TYPE'] == 'application/json' }
    end
  end