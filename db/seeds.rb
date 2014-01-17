# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# users
user_1 = User.create(name: "Anisha Ramnani",
												password: "1Anishatest",
												score: 1,
												email: "anisha.ramnnani@gmail.com")
user_2 = User.create(name: "Katie Hoffman",
                        password: "2Katietest",
                        score: 3,
                        email: "ktahoffman@gmail.com")
user_3 = User.create(name: "Armando Amador",
                        password: "3Armandotest",
                        score: 100,
                        email: "arm.amador@gmail.com")
user_4 = User.create(name: "David Gabeau",
                        password: "4Davidtest",
                        score: 999,
                        email: "david.gabeau@gmail.com")
# celebrities
celebrity_1 = Celebrity.create(name: "Justin Beiber",
                        handle: "@justinbieber")
celebrity_2 = Celebrity.create(name: "Lebron James",
                        handle: "@KingJames")
celebrity_3 = Celebrity.create(name: "Barney Stinson",
                        handle: "@itsBroStinson")

# # tweets
# tweet_1 = Tweet.create(
#                       celebrity_id: 1,        
#                       tweet: "live your dream. be creative")
# tweet_2 = Tweet.create(
#                       celebrity_id: 2,        
#                       tweet: "Happy Bday D.wade")
# tweet_3 = Tweet.create(
#                       celebrity_id: 3,        
#                       tweet: "Legiondary.")

# # answers
# answer_1 = Answer.create(
#                       celebrity_id: 1,       
#                       user_id: 2,
#                       guess: "Live your dream and be creative.")

# answer_2 = Answer.create(
#                       celebrity_id: 2,       
#                       user_id: 3,
#                       guess: "Happy Birthday D.wade")
# answer_2 = Answer.create(
#                       celebrity_id: 3,       
#                       user_id: 3,
#                       guess: "Legendary.")

