require_relative 'class_save'
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

user = User::find_by_id(4)
user.new_save

# question = Question::find_by_id(1)
# p question.likers
# p question.num_likes

# reply = Reply::find_by_id(3)
# reply.body = "great match today"
# p reply
# reply.save
# p reply

# p QuestionFollower::followers_for_question_id(2)
# p Question::most_followed(2)

# p QuestionLike::likers_for_question_id(1)
# p QuestionLike::num_likes_for_question_id(2)
# p QuestionLike::num_likes_for_question_id(3)
# p QuestionLike::liked_questions_for_user_id(3)

# p Question::most_liked(1)
# p user.average_karma


# question = Question::find_by_id(4)
# p question
# question.body = "I've just found my id!!"
# p question
# question.save
# p question

# reply = Reply.new({"body" => "Good match today!", "question" => 4, "author" => 1})
# reply.save
# p reply


