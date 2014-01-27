# require 'debugger'

class AnswersController < ApplicationController
  # GET /answers
  # GET /answers.json
  def index
    @user = User.find(params[:user_id])
    @answers = @user.answers
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.json
  def new
    @my_tweet = Tweet.all.sample
    @answer = Answer.new
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
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
    @user = User.find(params[:user_id])
    @tweet = Tweet.find(params[:answer][:tweet_id])
    @answer = @user.answers.build(params[:answer])
    my_answer = apply_regex(@answer.guess)
    if my_answer == @tweet.answer 
      @answer.correct = true 
    else 
      @answer.correct = false 
    end 
    respond_to do |format|
      if @answer.save
        format.html { redirect_to user_answer_path(@user, @answer), notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
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
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
    end
  end

  def rm_hashtags(text)
    text.gsub(/#\S*/, "")
    # This guess #has a hashtag. => "This guess  a hashtag."
  end

  def rm_weird_characters(text)
    text.gsub(/[^\w.;?!,' -]/, "")
    # "This guess has a ♥ that's a heart."=> "This guess has a  that's a heart."
  end

  def rm_url_guess(text)
    new_guess = text.gsub(/.*http:\/\/.*/, "")
    new_guess.gsub(/.*https:\/\/.*/, "")
    # "This guess has a link and it is this http://www.twitter.com." => ""
    # "This guess has a link and it is this https://www.twitter.com." => ""
  end

  def rm_at_guess(text)
    text.gsub(/.*@.*/, "")
    # "This guess has an @ sign." => ""
  end

  def rm_rt_guess(text)
    text.gsub(/.*rt.*/i, "")
    # "This is a rt of a different user." => ""
    # "This is a RT of a different user." => ""
  end

  def rm_word_tweet(text)
    text.gsub(/tweet\S*/i, "")
  end 
  
  def apply_regex(string)
    rm_weird_characters(rm_hashtags(rm_word_tweet(rm_url_guess(rm_at_guess(rm_rt_guess(string))))))   
  end
end