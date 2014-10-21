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
  
  def self.likers_for_question_id(question_id)
    query = <<-SQL
      SELECT
        u.id, u.fname, u.lname
      FROM
        users AS u
      JOIN
        question_likes AS ql
      ON
        u.id = ql.liker
      WHERE
        ql.question = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, question_id) || (return 0)
    likers = []
    array_hashes.each do |user_hash|
      likers << User.new(user_hash)
    end
    
    likers
  end
  
  def self.most_liked_questions(n)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.author
    FROM
      questions AS q
    JOIN
      question_likes AS ql
    ON
      q.id = ql.question
    GROUP BY
      ql.question
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
  
  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question = ?
      GROUP BY
        question
    SQL
    
    count = QuestionsDatabase.instance.execute(query, question_id).first || (return 0)
    count.values.first
  end
  
  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.author
    FROM
      questions AS q
    JOIN
      question_likes AS ql
    ON
      q.id = ql.question
    WHERE
      ql.liker = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, user_id)
    questions = []
    array_hashes.each do |question_hash|
      questions << Question.new(question_hash)
    end
    
    questions
  end
  
  def initialize(options = {})
    @id = options['id']
    @question = options['question']
    @liker = options['liker']
  end
end