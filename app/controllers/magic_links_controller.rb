class MagicLinksController < ApplicationController
  skip_before_action :logged_in_user

  def new

  end
end
