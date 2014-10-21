class Reply
  attr_accessor :id, :body, :subject, :parent, :responder
  
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
    @subject = options['subject']
    @parent = options['parent']
    @responder = options['responder']
  end
end