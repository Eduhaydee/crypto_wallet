class WelcomeController < ApplicationController
  def index
    cookies[:curso] = 'Curso de Ruby on Rails'
    session[:about] = 'Novo sistema de aprendizado'
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
