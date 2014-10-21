CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author INTEGER NOT NULL,
  FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  follower INTEGER NOT NULL,
  FOREIGN KEY (question) REFERENCES questions(id),
  FOREIGN KEY (follower) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(255) NOT NULL,
  subject INTEGER NOT NULL,
  parent INTEGER,
  responder INTEGER NOT NULL,
  FOREIGN KEY (subject) REFERENCES questions(id),
  FOREIGN KEY (parent) REFERENCES replies(id),
  FOREIGN KEY (responder) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  liker INTEGER NOT NULL,
  FOREIGN KEY (question) REFERENCES questions(id),
  FOREIGN KEY (liker) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("john", "smith"),
  ("sarah", "johnson"),
  ("derek", "jeter");
  
INSERT INTO
  questions (title, body, author)
VALUES
  ('Bomb', 'Where is the bomb?', (SELECT id FROM users WHERE fname = 'john')),
  ('Child', 'Have you seen my child?', (SELECT id FROM users WHERE fname = 'derek'));
  
INSERT INTO
  question_followers (question, follower)
VALUES
  ((SELECT id FROM questions WHERE title = 'Bomb'),
   (SELECT id FROM users WHERE fname = 'sarah')),
  ((SELECT id FROM questions WHERE title = 'Child'),
   (SELECT id FROM users WHERE fname = 'john'));
   
INSERT INTO
  replies (body, subject, parent, responder)
VALUES
  ("I don't know where your child is.", (SELECT id FROM questions WHERE title = 'Child'),
   NULL, (SELECT id FROM users WHERE fname = 'john')),
  ("Your child is with me", (SELECT id FROM questions WHERE title = 'Child'),
   (SELECT id FROM replies WHERE body = "I don't know where your child is."),
   (SELECT id FROM users WHERE fname = 'sarah'));
   
INSERT INTO
  question_likes (question, liker)
VALUES
  ((SELECT id FROM questions WHERE title = 'Bomb'),
   (SELECT id FROM users WHERE fname = 'derek')),
  ((SELECT id FROM questions WHERE title = 'Child'),
   (SELECT id FROM users WHERE fname = 'sarah'));