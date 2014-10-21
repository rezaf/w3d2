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
  
  def self.most_liked(n)
    QuestionLike::most_liked_questions(n)
  end
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end
  
  def followers
    QuestionFollower::followers_for_question_id(@id)
  end
  
  def likers
    QuestionLike::likers_for_question_id(@id)
  end
  
  def num_likes
    QuestionLike::num_likes_for_question_id(@id)
  end
  
  def replies
    Reply::find_by_question_id(@id)
  end
  
  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author)
        INSERT INTO
          questions (title, body, author)
        VALUES
          (?, ?, ?)
      SQL
         
      @id = QuestionsDatabase.instance.last_insert_row_id
    
    else
      param_hash = { :title => @title, :body => @body,
                     :author => @author, :id => @id}
      QuestionsDatabase.instance.execute(<<-SQL, param_hash)
        UPDATE
          questions
        SET
          title = :title,
          body = :body,
          author = :author
        WHERE
          id = :id
      SQL
    end
  end
end