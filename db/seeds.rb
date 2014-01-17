# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# users
user_1 = User.create(name: "Anisha Ramnani",
												password: "anishatest",
												score: 1,
												email: "anisha.ramnnani@gmail.com")

user_2 = User.create(name: "Katie Hoffman",
                        id: 2
                        password: "katietest",
                        score: 3,
                        email: "ktahoffman@gmail.com")
user_3 = User.create(name: "Armando Amador",
                        id: 3
                        password: "armandotest",
                        score: 100,
                        email: "arm.amador@gmail.com")
# celebrities
celebrity_1 = Celebrity.create(
                        id: 1,
                        name: "Justin Beiber",
                        handle: "@justinbieber")
celebrity_2 = Celebrity.create(
                        id: 2,
                        name: "Lebron James",
                        handle: "@KingJames")

# tweets
tweet_1 = Tweet.create(id: 1,
                      celebrity_id: 1,        
                      tweet: "live your dream. be creative")
tweet_2 = Tweet.create(id: 1,
                      celebrity_id: 2,        
                      tweet: "Happy Bday D.wade")

# answers
answer_1 = Answer.create(id: 1,
                      celebrity_id: 1,       
                      user_id: 2,
                      guess: "Live your dream and be creative.")

answer_2 = Answer.create(id: 2,
                      celebrity_id: 2,       
                      user_id: 3,
                      guess: "Happy Birthday D.wade")

