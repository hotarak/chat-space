class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to  group_messages_path(@group), notice: 'チャットグループが作成されました'
    else
      render :new
    end
  end

  def edit
    @users = @group.users
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group),  notice: 'チャットグループが更新されました'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
