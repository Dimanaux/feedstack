class FeedbacksController < ApplicationController
  before_action :set_page, only: [:index]

  def index
    authorize Feedback, :index?
    @feedbacks =
        Feedback.where("name LIKE :w OR text LIKE :w OR email LIKE :w",
                       { w: "%%#{params[:query] || ''}%%" })
                .order(created_at: :desc)
                .page(@page)
  end

  def success; end

  def new
    @feedback = Feedback.new
    if user_signed_in?
      @feedback.email = current_user.email
      @feedback.name = current_user.full_name
    end
  end

  def create
    @feedback = Feedback.new(feedback_params)

    respond_to do |format|
      if @feedback.save
        FeedbackMailer.with(feedback: @feedback).new_feedback_email.deliver_now

        format.html { redirect_to :feedbacks_success,
                      notice: 'Feedback was successfully sent!' }
        format.json { render :show, status: :created,
                      location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private

  def feedback_params
    params.fetch(:feedback, {})
    params.require(:feedback).permit(:name, :email, :text, :page, :query)
  end

  def set_page
    @page = params[:page] || 1
  end
end
