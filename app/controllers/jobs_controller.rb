# encoding: utf-8
class JobsController < ApplicationController
  respond_to :html, :json

  def index
    @jobs = Job.order(:name)
    job_list = @jobs.where("name ilike ?", "%#{params[:q]}%").map {|j| {id: j.id, name: j.name} } 
    job_query = job_list.empty? ? [{id: "<<<#{params[:q]}>>>", name: "NOVA ATUAÇÃO: \"#{params[:q]}\""}] : job_list
    respond_with(@job) do |format|
      format.json { render json: job_query }
    end
  end

  def show
  end

  def create
    @job = Job.new job_params
  end

  private

  def job_params
    params.require(:job).permit(:name)
  end

end
