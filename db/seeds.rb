# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "Anisha Ramnani",
                        id: 1,
                        password: "1Anishatest",
                        score: 1,
                        email: "anisha.ramnnani@gmail.com")

User.create(name: "Katie Hoffman",
                        id: 2,
                        password: "2Katietest",
                        score: 3,
                        email: "ktahoffman@gmail.com")
User.create(name: "Armando Amador",
                        id: 3,
                        password: "3Armandotest",
                        score: 100,
                        email: "arm.amador@gmail.com")
User.create(name: "David Gabeau",
                        id: 4,
                        password: "4Davidtest",
                        score: 999,
                        email: "david.gabeau@gmail.com")


#  celebrities
#  Celebrity.create(
#                         id: 1,
#                         name: "Twidder App",
#                         handle: "@twidder_app")

# Celebrity.create(
#                         id: 1,
#                         name: "Justin Beiber",
#                         handle: "@justinbieber")
# Celebrity.create(
#                         id: 2,
#                         name: "Lebron James",
#                         handle: "@KingJames")
# Celebrity.create(
#                         id: 3,
#                         name: "Barney Stinson",
#                         handle: "@itsBroStinson")

# # tweets
# Tweet.create(
#                       celebrity_id: 1,        
#                       tweet: "live your dream. be creative")
# Tweet.create(
#                       celebrity_id: 2,        
#                       tweet: "Happy Bday D.wade")
# Tweet.create(
#                       celebrity_id: 3,        
#                       tweet: "Legiondary.")

# # answers
# Answer.create(
#                       tweet_id: 1,       
#                       user_id: 2,
#                       guess: "Live your dream and be creative.")

# Answer.create(
#                       tweet_id: 2,       
#                       user_id: 2,
#                       guess: "Live your dream and be creative.")

# Answer.create(
#                       tweet_id: 2,       
#                       user_id: 3,
#                       guess: "Happy Birthday D.wade")
# Answer.create(
#                       tweet_id: 3,       
#                       user_id: 3,
#                       guess: "Legendary.")