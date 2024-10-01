class VotesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @votable = find_votable
      vote = @votable.votes.where(user: current_user).first_or_initialize
  
      if vote.new_record?
        vote.save
        redirect_back(fallback_location: root_path, notice: 'Thank you for voting!')
      else
        redirect_back(fallback_location: root_path, alert: 'You have already voted.')
      end
    end
  
    def destroy
      @votable = find_votable
      vote = @votable.votes.where(user: current_user).destroy_all
      redirect_back(fallback_location: root_path, notice: 'Your vote has been removed.')
    end
  
    private
  
    def find_votable
      if params[:article_id]
        Article.find(params[:article_id])
      elsif params[:comment_id]
        Comment.find(params[:comment_id])
      end
    end
  end
  