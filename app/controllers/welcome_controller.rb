require 'github/markup'
class WelcomeController < ApplicationController
  def index
    file = "#{Rails.root}/README.md"
    @readme = GitHub::Markup.render(file, File.read(file))
  end
end
