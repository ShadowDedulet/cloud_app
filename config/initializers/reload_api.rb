if Rails.env == "development"
  api_reloader = ActiveSupport::FileUpdateChecker.new(Dir[Rails.root.join('app', 'api', '**', '*.rb')]) do
    puts ">>>> RELOADING!"
    Rails.application.reload_routes!
  end

  ActionDispatch::Callbacks.to_prepare do
    api_reloader.execute_if_updated
  end
end