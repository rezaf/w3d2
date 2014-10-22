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
user.fname = "David"
user.lname = "Villa"
p user
user.new_save
p user

# question = Question::find_by_id(1)
# p question.likers
# p question.num_likes

reply = Reply::find_by_id(3)
reply.body = "great day for tuesday"
p reply
reply.new_save
p reply

# p QuestionFollower::followers_for_question_id(2)
# p Question::most_followed(2)

# p QuestionLike::likers_for_question_id(1)
# p QuestionLike::num_likes_for_question_id(2)
# p QuestionLike::num_likes_for_question_id(3)
# p QuestionLike::liked_questions_for_user_id(3)

# p Question::most_liked(1)
# p user.average_karma


question = Question::find_by_id(4)
question.body = "this is working!!"
p question
question.new_save
p question

# reply = Reply.new({"body" => "Good match today!", "question" => 4, "author" => 1})
# reply.save
# p reply


