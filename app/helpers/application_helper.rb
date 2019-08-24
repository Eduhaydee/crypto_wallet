module ApplicationHelper
  def locale
    I18n.locale == :en ? 'Inglês - US' : 'Porguês - BR'
  end

  def date_br(date_us)
    date_us.strftime('%d/%m/%Y')    
  end
  
  def env_rails
    if Rails.env.development?
      'Development'
    elsif Rails.env.production?
      'Production'
    else
      'Test'
    end
  end
  
end
