class BadgeSetsController < ApplicationController
  respond_to :html
  
  before_filter -> { @badge_set = BadgeSet.find(params[:id]) }, only: [:print, :edit, :update, :destroy]
  
  def print
    respond_with @badge_set, layout: 'print'
  end
  
  def index
    @badge_sets = BadgeSet.page(params[:page]).per(20)
    respond_with @badge_sets
  end

  def new
    @badge_set = BadgeSet.new
    respond_with @badge_set
  end

  def edit
    respond_with @badge_set
  end

  def create
    @badge_set = BadgeSet.new(params[:badge_set])

    respond_to do |format|
      if @badge_set.save
        format.html { redirect_to badge_set_badges_url(@badge_set), notice: I18n.t('controllers.badge_sets.actions.create.notice') }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @badge_set.update_attributes(params[:badge_set])
        format.html { redirect_to badge_set_badges_url(@badge_set), notice: I18n.t('controllers.badge_sets.actions.update.notice') }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @badge_set.destroy

    respond_to do |format|
      format.html { redirect_to badge_sets_url, notice: I18n.t('controllers.badge_sets.actions.destroy.notice') }
    end
  end
end
