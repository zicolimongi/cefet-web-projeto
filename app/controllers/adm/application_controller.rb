class Adm::ApplicationController < ApplicationController
  before_action :authenticate_admin!
end
