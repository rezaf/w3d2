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
  
  def self.find_by_author_id(author_id)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        author = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, author_id)
    questions = []
    array_hashes.each do |hash_question|
      questions << self.new(hash_question)
    end
      
    questions
  end
  
  def self.most_followed(n)
    QuestionFollower::most_followed_questions(n)
  end
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end
  
  def replies
    Reply::find_by_question_id(@id)
  end
  
  def followers
    QuestionFollower::followers_for_question_id(@id)
  end
end