class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])
    @user = User.find(params[:user_id])
    @tweet = Tweet.find(@answer.tweet_id)
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @tweet = Tweet.all.sample
    @answer = Answer.new
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
    @user = User.find(params[:user_id])
  end

  # POST /answers
  # POST /answers.json
  def create
    # debugger
    @user = User.find(params[:user_id])
    @tweet = Tweet.find(params[:answer][:tweet_id])
    @answer = @user.answers.build(params[:answer])
    regex_1 = @answer.apply_regex(@answer.guess)
    regex_2 = regex_1.gsub(/[^\w ']/, "") # removes all but numbers, letters, and ' <= those things
    regex_3 = regex_2.gsub(/(\d)/,"") # removes numbers
    my_answer = regex_3.split(" ") # => ["I", "love", "u"]
    index = 0
    if my_answer.length == @tweet.answer.length
      @answer.correct = true
      my_answer.each do |word|
        if !@tweet.answer[index].include?(word) # [["I"], ["love"], ["you", "urn", "your"]]
          @answer.correct = false
          break
        end 
        index += 1
      end
    end
    if @answer.correct
      @user.update_attribute(:score, @user.score + 1)
    end
    respond_to do |format|
      if @answer.save
        format.html { redirect_to user_answer_path(@user, @answer), notice: 'Answer was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to user_answer_path(@user, @answer), notice: 'Answer was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer = Answer.find(params[:id])
    @user = User.find(params[:user_id])
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to user_answers_url }
    end
  end
end