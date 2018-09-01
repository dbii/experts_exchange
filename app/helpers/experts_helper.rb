module ExpertsHelper

  def introduction_path(expert, target)
    experts = expert.path_to_expert(target)
    return "Sorry, no introduction path" unless experts
    experts.map{|e| e.name}.join(" => ")
  end

end
