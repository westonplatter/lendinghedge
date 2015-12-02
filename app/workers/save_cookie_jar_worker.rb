class SaveCookieJarWorker
  include Sidekiq::Worker

  def perform
    agent = Mechanize.new { |a|
      a.user_agent_alias = 'Mac Safari'
    }

    agent.get('https://www.lendingclub.com/account/gotoLogin.action')do |page|
      page.form_with(:action => '/account/login.action') do |form|
        form.login_email =  ENV['LENDINGCLUB_EMAIL']
        form.login_password = ENV['LENDINGCLUB_PASSWORD']
      end.submit
    end

    agent.cookie_jar.save_as \
      Rails.root.join("data_cookies/lendingclub_cookies.yml"),
      :session => true,
      :format => :yaml
  end

end
