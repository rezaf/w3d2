class QuestionFollower
  attr_accessor :id, :question, :follower
  
  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        question_followers
      WHERE
      id = ?
    SQL
    
    hash_question_follower = QuestionsDatabase.instance.execute(query, id)
    self.new(hash_question_follower.first)
  end
  
  def initialize(options = {})
    @id = options['id']
    @question = options['question']
    @follower = options['follower']
  end
end