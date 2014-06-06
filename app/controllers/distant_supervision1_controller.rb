class DistantSupervision1Controller < ApplicationController

  def show id = nil
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

  def tutorial1
  	@sentence = Sentence.find(34)
  end

end
