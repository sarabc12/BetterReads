class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @books = Book.order("RANDOM()").limit(6)
    @news = News.order('RANDOM()').limit(2)
  end
end
