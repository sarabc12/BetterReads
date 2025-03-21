class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @news = News.order('RANDOM()').limit(4)
  end
end
