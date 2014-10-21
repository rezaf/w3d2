class Question
  attr_accessor :id, :title, :body, :author
  
  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
      id = ?
    SQL
    
    hash_question = QuestionsDatabase.instance.execute(query, id)
    self.new(hash_question.first)
  end
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end
end