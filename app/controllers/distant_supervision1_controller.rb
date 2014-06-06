class DistantSupervision1Controller < ApplicationController

  def task id = nil
  	if(id.nil?)
  		@sentence = Sentence.includes("relations").where(relations: {in_sentence:nil}).take
  	else
  		@sentence = Sentence.includes("relations").find(id)
  	end
  end

  def update
  	params[:in_sentence].each do |key, val|
  		rel = Relation.find(key)
  		rel.in_sentence = Integer(val)
  		rel.save
  	end
  	redirect_to action: 'show'
  end

  def login 

  end

  def tutorial2

  end

  def tutorial3

  end

  def tutorial1
  	
  end


end
