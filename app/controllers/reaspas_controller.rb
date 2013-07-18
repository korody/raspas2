# encoding: utf-8
class ReaspasController < ApplicationController
  before_action :authenticate

  def create
    raspa = Raspa.find_by(id: params[:raspa_id])
    @reaspa = current_user.reaspas.build(
      raspa: raspa, 
      status: "recitado por #{current_user.name} e mais #{raspa.citations.size}")
      if @reaspa.save
        flash[:notice] = "recitado!"
        redirect_to root_url
      else
        flash[:error] = "pera que deu pêra!"
        redirect_to root_url
    end
  end

  # def citacao_por(citante)
  #   if self.user == citante
  #     "Esta raspa é mesmo muito boa! Infelizmente não é possível citar sua própria raspa. : /"
  #   elsif self.raspas.where(user_id: citante.id).present?
  #     "Queria eu citar esta raspa mil vezes! Mas só é possível uma vez..."
  #   else
  #     current_user.raspas.create(
  #       status: "reaspa #{raspa.author.name}: #{raspa.status}",
  #       raspa_original: @raspa )
  #     "raspa citada!"          
  #   end
  # end

  def destroy
    @reaspa = current_user.reaspas.find(params[:id])
    @reaspa.destroy
    flash[:notice] = "ufaned!"
    redirect_to authors_raspas_path(current_user.username)
  end

end
