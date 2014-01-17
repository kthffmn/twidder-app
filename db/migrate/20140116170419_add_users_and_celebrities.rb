class AddUsersAndAnswers < ActiveRecord::Migration
  def up
    User.create(name: "Anisha Ramnani",
                            password: "1Anishatest",
                            score: 1,
                            email: "anisha.ramnnani@gmail.com")
    User.create(name: "Katie Hoffman",
                            password: "2Katietest",
                            score: 3,
                            email: "ktahoffman@gmail.com")
    User.create(name: "Armando Amador",
                            password: "3Armandotest",
                            score: 100,
                            email: "arm.amador@gmail.com")
    User.create(name: "David Gabeau",
                            password: "4Davidtest",
                            score: 999,
                            email: "david.gabeau@gmail.com")
    Celebrity.create(name: "Justin Beiber",
                            handle: "@justinbieber")
    Celebrity.create(name: "Lebron James",
                            handle: "@KingJames")
    Celebrity.create(name: "Barney Stinson",
                            handle: "@itsBroStinson")
  end

  def down
    User.drop_all
    Celebrity.drop_all
  end
end