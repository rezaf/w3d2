class QuestionLike
  attr_accessor :id, :question, :liker
  
  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        question_likes
      WHERE
      id = ?
    SQL
    
    hash_question_likes = QuestionsDatabase.instance.execute(query, id)
    self.new(hash_question_likes.first)
  end
  
  def initialize(options = {})
    @id = options['id']
    @question = options['question']
    @liker = options['liker']
  end
end