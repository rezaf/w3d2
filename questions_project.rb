require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_follower'
require_relative 'reply'
require_relative 'question_like'

# p User::find_by_name('john', 'smith')
# p Question::find_by_id(1)
# p QuestionFollower::find_by_id(1)
# p Reply::find_by_id(1)
# p QuestionLike::find_by_id(1)

user = User::find_by_name('john', 'smith')
p user.authored_replies