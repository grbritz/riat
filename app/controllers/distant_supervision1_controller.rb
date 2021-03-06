class DistantSupervision1Controller < ApplicationController
  include DistantSupervision1Helper
  before_filter :require_logged_in

  def task
    @current_sentence ||= get_sentence(current_user)
    if(!@current_sentence.nil?)
      @target_route = "/distant_supervision1/update"
      render template: "layouts/distant_supervision_experiment"
    else
      #completed with the task
      redirect_to action: "thank_you"
    end
    
  end

  def update
    annParams = []

    @current_sentence = get_sentence(current_user)
    if(!done_all_annotations)
      flash.now[:message] = {display_type: "danger", message: "You must make annotations for every instance shown"}
      render template: "layouts/distant_supervision_experiment" 
      return
    end

    params[:annotation].each do |relID, annVal|
      ann = {relation_instance_id: relID, user_id: current_user.id, annotation: annVal}
      annParams.push(ann)
    end

    #is_good_pattern is optional
    if(!params[:is_bad_pattern].nil?)
      params[:is_bad_pattern].each do |relID, is_bad_pattern|
        annIndex = annParams.find_index{|ele| ele[:relation_instance_id] == relID}
        annParams[annIndex].merge!({is_bad_pattern: is_bad_pattern})
      end
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
      @current_sentence.complete_for(current_user)
      redirect_to action: 'task'
    else
      flash.now[:message] = {display_type: "danger", message: "You must have a reason for choosing 'Not sure' on an annotation"}
      render template: "layouts/distant_supervision_experiment"
    end
  end

  def index
    render 'distant_supervision1/tutorial1'
  end

  def tutorial3
  end
  def tutorial2
  end

  def tutorial1
  end

  def thank_you
    
  end

  private 

    def annotation_params
      params.permit(annotation: [], is_good_pattern: [])
    end

    def done_all_annotations
      (!params[:annotation].nil? && params[:annotation].count == @current_sentence.relation_instances.count)
    end
end
