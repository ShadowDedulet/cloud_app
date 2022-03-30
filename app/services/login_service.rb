class LoginService
  attr_reader :params, :session

  def initialize(params, session)
    @params, @session = params, session
  end
  
  def call
    notice = check_password
    return notice if notice

    modify_session
    message
  end

  private

  def check_password
    'Неверный пароль' unless @params[:password] == '123'
  end

  def modify_session
    @session[:login] = @params[:login]
    @session[:balance] ||= 1000
  end

  def message
    "#{get_time_notice}, #{@session[:login]}"
  end

  def get_time_notice
    notices = ['Доброе утро', 'Добрый день', 'Добрый вечер', 'Доброй ночи']
    hour = Time.now.hour
    case hour
    when 5..11
      notices[0]
    when 12..16
      notices[0]
    when 17..23
      notices[2]
    else
      notices[3]
    end
  end
end
