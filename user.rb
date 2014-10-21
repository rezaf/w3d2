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
    query = <<-SQL
      SELECT
        id
      FROM
        questions
      WHERE
        author = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, @id)
    questions = []
    array_hashes.each do |hash_question|
      id_question = hash_question['id']
      questions << Question::find_by_id(id_question)
    end
      
    questions
  end
  
  def authored_replies
    query = <<-SQL
      SELECT
        id
      FROM
        replies
      WHERE
        responder = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, @id)
    replies = []
    array_hashes.each do |hash_reply|
      id_reply = hash_reply['id']
      replies << Reply::find_by_id(id_reply)
    end
      
    replies
  end
end
