class Api::V1::ListItemsController < Api::V1::BaseController

  inherit_resources

  def create
    respond_to do |format|
      #TODO remove next line
      current_user = User.first
      list = current_user.lists.find params[:list_id]
      if list.list_items.create(params[:list_item])
        format.json { render json: true }
      else
        format.json { render :json => "Error creating list item.", :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      #TODO remove next line
      current_user = User.first
      list = current_user.lists.find params[:list_id]
      list_item = list.list_items.find params[:id]
      if list_item.update_attributes(params[:list_item])
        format.json { respond_with list_item }
      else
        format.json { render :json => "Error updating list item.", :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      #TODO remove next line
      current_user = User.first
      list = current_user.lists.find params[:list_id]
      list_item = list.list_items.find params[:id]
      if list_item.destroy
        format.json { respond_with list_item }
      else
        format.json { render :json => "Error removing list item.", :status => :unprocessable_entity }
      end
    end
  end

end
