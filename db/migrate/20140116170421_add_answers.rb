class AddAnswers < ActiveRecord::Migration
  def up
    Answer.create(
                          celebrity_id: 1,       
                          user_id: 2,
                          guess: "Live your dream and be creative.")

    Answer.create(
                          celebrity_id: 2,       
                          user_id: 3,
                          guess: "Happy birthday D. Wade")
    Answer.create(
                          celebrity_id: 3,       
                          user_id: 3,
                          guess: "Legendary.")

     end

  def down
    Answer.delete_all
  end

end