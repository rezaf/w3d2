class Reply
  attr_accessor :id, :body, :question, :parent_reply, :author
  
  def self.find_by_question_id(question_id)
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        question = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, question_id)
    replies = []
    array_hashes.each do |hash_reply|
      replies << self.new(hash_reply)
    end
    replies
  end
  
  def self.find_by_user_id(user_id)
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        author = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, user_id)
    replies = []
    array_hashes.each do |hash_reply|
      replies << self.new(hash_reply)
    end
      
    replies
  end
  
  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    
    hash_replies = QuestionsDatabase.instance.execute(query, id)
    self.new(hash_replies.first)
  end
  
  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @question = options['question']
    @parent_reply = options['parent_reply']
    @author = options['author']
  end
  
  def child_replies
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply = ?
    SQL
    
    array_hashes = QuestionsDatabase.instance.execute(query, @id)
    replies = []
    array_hashes.each do |hash_reply|
      replies << Reply.new(hash_reply)
    end
      
    replies
  end
  
  def save
    if @id.nil?
      params = [@body, @question, @parent_reply, @author]
      QuestionsDatabase.instance.execute(<<-SQL, *params)
        INSERT INTO
          replies (body, question, parent_reply, author)
        VALUES
          (?, ?, ?, ?)
      SQL
         
      @id = QuestionsDatabase.instance.last_insert_row_id
    
    else
      param_hash = { :body => @body, :question => @question, :author => @author,
                     :parent_reply => @parent_reply, :id => @id}
      QuestionsDatabase.instance.execute(<<-SQL, param_hash)
        UPDATE
          replies
        SET
          body = :body,
          question = :question,
          author = :author,
          parent_reply = :parent_reply
        WHERE
          id = :id
      SQL
    end
  end
end