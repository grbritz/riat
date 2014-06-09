class DistantSupervision1Controller < ApplicationController
  include DistantSupervision1Helper

  before_filter :require_logged_in

  def task
    @current_sentence ||= get_sentence(current_user)
    @target_route = "/distant_supervision1/update"
  	render template: "layouts/distant_supervision_experiment"
  end

  def update
    annParams = []

    @current_sentence = get_sentence(current_user)
    if(params[:annotation].nil?)
      flash.now[:error] = "You must make annotations for every instance shown"
      render template: "layouts/distant_supervision_experiment" 
      return
    end

    params[:annotation].each do |relID, annVal|
      ann = {relation_instance_id: relID, user_id: current_user.id, annotation: annVal}
      annParams.push(ann)
    end

    params[:is_good_pattern].each do |relID, isGoodPattern|
      annIndex = annParams.find_index{|ele| ele[:relation_instance_id] == relID}
      annParams[annIndex].merge!({is_good_pattern: isGoodPattern})
    end

    @annotations = []
    allGood = true

    annParams.each do |ann|
      annotation = Annotation.new(ann)
      @annotations.push(annotation)
      if(!annotation.valid?)
        allGood = false;
      end
    end

    if(allGood)

      @annotations.each do |ann|
        ann.save()
      end
      @annotations = nil
      @current_sentence.complete_for(current_user)
      @current_sentence = get_sentence(current_user)
    end

    redirect_to action: 'task'

  end

  def index
    render 'distant_supervision1/tutorial1'
  end

  def tutorial2

  end

  def tutorial3

  end

  def tutorial1

  end

  private 

    def annotation_params
      params.permit(annotation: [], is_good_pattern: [])
    end
end
