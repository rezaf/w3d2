class Class
  def save
    self.instance_variables.map do |variable|
      variable.to_s.gsub!(/[@]/, '').to_s
    end
  end
end