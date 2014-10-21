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
  
  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT
      u.id, u.fname, u.lname
    FROM
      users AS u
      JOIN
      question_followers AS qf
      ON
      u.id = qf.follower
    WHERE
      qf.question = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, question_id)
    followers = []
    array_hashes.each do |user_hash|
      followers << User.new(user_hash)
    end
    
    followers
  end
  
  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.author
    FROM
      questions AS q
    JOIN
      question_followers AS qf
    ON
      q.id = qf.question
    WHERE
      qf.follower = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, user_id)
    questions = []
    array_hashes.each do |question_hash|
      questions << Question.new(question_hash)
    end
    
    questions
  end
  
  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.author
    FROM
      questions AS q
    JOIN
      question_followers AS qf
    ON
      q.id = qf.question
    GROUP BY
      qf.question
    ORDER BY
      COUNT(*) DESC
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query)
    questions = []
    array_hashes[0...n].each do |question_hash|
      questions << Question.new(question_hash)
    end
    
    questions
  end
  
  def initialize(options = {})
    @id = options['id']
    @question = options['question']
    @follower = options['follower']
  end
end