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
end
