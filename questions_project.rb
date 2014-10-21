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

# user = User::find_by_name('john', 'smith')
# p user.followed_questions

# question = Question::find_by_id(2)
# p question.replies

# reply = Reply::find_by_id(1)
# p reply.child_replies

# p QuestionFollower::followers_for_question_id(2)
# p Question::most_followed(2)

# p QuestionLike::likers_for_question_id(1)
# p QuestionLike::num_likes_for_question_id(1)
p QuestionLike::liked_questions_for_user_id(3)