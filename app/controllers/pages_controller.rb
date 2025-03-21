class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @books = Book.order("RANDOM()").limit(5)
    @news = News.order('RANDOM()').limit(4)
  end
end
