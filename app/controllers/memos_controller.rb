class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @memos = Memo.all
    respond_with(@memos)
  end

  def show
    respond_with(@memo)
  end

  def new
    @memo = Memo.new
    respond_with(@memo)
  end

  def edit
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.save
    respond_with(@memo)
  end

  def update
    @memo.update(memo_params)
    respond_with(@memo)
  end

  def destroy
    @memo.destroy
    respond_with(@memo)
  end

  private
    def set_memo
      @memo = Memo.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:title, :description, :address, :latitude, :longitude, :user_id)
    end
end
