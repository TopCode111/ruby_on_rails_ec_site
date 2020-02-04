if Rails.env == 'production' || Rails.env == 'staging'
  require 'airbrake'
  Airbrake.configure do |config|
    config.host = 'http://errbit.jyaasa.com'
    config.project_id = 1
    config.project_key = '0e7c1ba6e334b032311be0349ecace97'
    config.logger = Rails.logger
    config.root_directory = Rails.root
    config.environment = Rails.env
  end
  Airbrake.add_filter do |notice|
    # See: https://github.com/phusion/passenger/issues/1730
    passenger_error = proc do |error|
      error[:backtrace].empty? &&
        error[:type] == 'NoMethodError' &&
        error[:message] =~ /undefined method `call'/
    end

    notice.ignore! if notice[:errors].any?(&passenger_error)
  end
end
