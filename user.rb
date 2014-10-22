class User
  attr_accessor :id, :fname, :lname
  
  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    
    hash_user = QuestionsDatabase.instance.execute(query, id)
    self.new(hash_user.first)
  end
  
  def self.find_by_name(fname, lname)
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
      AND
        lname = ?
    SQL
    
    hash_user = QuestionsDatabase.instance.execute(query, fname, lname)
    self.new(hash_user.first)
  end
  
  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def authored_questions
    Question::find_by_author_id(@id)
  end
  
  def authored_replies
    Reply::find_by_user_id(@id)
  end
  
  def followed_questions
    QuestionFollower::followed_questions_for_user_id(@id)
  end
  
  def liked_questions
    QuestionLike::liked_questions_for_user_id(@id)
  end
  
  def average_karma
    query_a = <<-SQL
      SELECT
        CAST(COUNT(*) AS FLOAT)
      FROM
        questions
      WHERE
        author = ?
      GROUP BY
        author
    SQL
    
    q_count = QuestionsDatabase.instance.execute(query_a, @id).first || (return 0)
    num_questions = q_count.values.first
    
    query_b = <<-SQL
      SELECT
        CAST(COUNT(*) AS FLOAT)
      FROM
        question_likes AS ql
      JOIN
        questions AS q
      ON
        ql.question = q.id
      WHERE
        q.author = ?
      GROUP BY
        q.author
    SQL
    
    l_count = QuestionsDatabase.instance.execute(query_b, @id).first || (return 0)
    num_likes = l_count.values.first
    
    num_likes / num_questions
  end
  
  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
         
      @id = QuestionsDatabase.instance.last_insert_row_id
    
    else
      param_hash = { :fname => @fname, :lname => @lname, :id => @id}
      QuestionsDatabase.instance.execute(<<-SQL, param_hash)
        UPDATE
          users
        SET
          fname = :fname,
          lname = :lname
        WHERE
          id = :id
      SQL
      
    end
  end
end
