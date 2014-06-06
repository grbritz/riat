class DistantSupervision1Controller < ApplicationController

  def task
  	if(params[:id].nil?)
  		@sentence = Sentence.includes("relation_instances").take
  	else
  		@sentence = Sentence.includes("relation_instances").find(id)
  	end

  	render template: "layouts/distant_supervision_experiment"
  end

  def update
  	params[:in_sentence].each do |key, val|
  		rel = Relation.find(key)
  		rel.in_sentence = Integer(val)
  		rel.save
  	end
  	redirect_to action: 'show'
  end

  def index
    render template: "layouts/login"
  end

  def tutorial2

  end

  def tutorial3

  end

  def tutorial1

  end

  def login
    email = params[:email]

    #TODO: Use an actual signup & login system
    user = (User.where(email: email).count == 0) ? 
      User.create(email: email) : User.where(email: email)

    
    if()
      
    end
  end


end
