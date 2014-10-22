require 'active_support/inflector'

class Object
  def new_save
    names_var = []
    inst_var = self.instance_variables.map do |variable|
      var_string = variable.to_s.gsub(/[@]/, '')
      names_var << var_string
      variable.to_s.gsub!(/[@]/, '').to_s
    end
    
    params = []
    inst_var.each do |var|
      params << self.method(var).call
    end
    
    var_hash = {}
    params.each_index do |index|
      var_hash[names_var[index]] = params[index]
    end
    
    table_name = "#{self.class.to_s.downcase.pluralize}"
    
    if var_hash["id"].nil?
      # INSERT INTO
      #   users (fname, lname)
      # VALUES
      #   (?, ?)
      #
      # #INSERT
      #
      # sql_statement = <<-SQL
      #   INSERT INTO #{table_name} (#{variable_string})
      #   VALUES #{values_string}
      # SQL
    else
      set_var = []
      var_hash.each do |key, value|
        next if key == "id"
        set_var << "#{key} = '#{value}'"
      end
    
      set_var_str = set_var.join(", ")
    
      id_str = "id = #{var_hash['id']}"
          
      sql_statement = <<-SQL
        UPDATE #{table_name}
        SET #{set_var_str}
        WHERE #{id_str}
      SQL
    
      QuestionsDatabase.instance.execute(sql_statement)
    end
  end
end