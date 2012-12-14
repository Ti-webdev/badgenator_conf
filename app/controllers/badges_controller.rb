class BadgesController < ApplicationController
  respond_to :html
  
  before_filter -> { @badge_set = BadgeSet.find(params[:badge_set_id]) }
  before_filter -> { @badge = Badge.find(params[:id]) }, except: [:create, :new, :index]
  
  def show
    respond_with @badge
  end

  def index
    @badges = @badge_set.badges.page(params[:page]).per(5)

    respond_to { |format| format.html }
  end

  def new
    @badge = Badge.new

    respond_to { |format| format.html }
  end

  def edit
    respond_with @badge
  end

  def create
    @badge = @badge_set.badges.new(params[:badge])

    respond_to do |format|
      if @badge.save
        format.html { redirect_to [@badge_set, @badge], notice: I18n.t('controllers.badges.actions.create.notice') }
      else
        format.html { render action: :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        format.html { redirect_to badge_set_badges_url(@badge_set), notice: I18n.t('controllers.badges.actions.update.notice') }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to badge_set_badges_url(@badge_set), notice: I18n.t('controllers.badges.actions.destroy.notice') }
    end
  end
end
