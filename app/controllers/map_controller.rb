class MapController < ApplicationController
    def index
    # @memos = User.all
    # @memos =Memo.all
    # session["init"] = true ;
  
    p session[:id] ;
    p cookies[:user_name] ;
    # binding.pry ;
    # @user = User.find(session[:id])
    # @user=Player.find(8)
    # @memos =Memo.where(user_id:session[:user_id])
    @memos =Memo.where(user_id:session[:id])
    begin
    @hash = Gmaps4rails.build_markers(@memos) do |user, marker|
      # 以下　marker [key] [value]のように指定可能
      marker.lat user.latitude
      marker.lng user.longitude
      # marker.infowindow user.description
     # marker.infowindow "<b>" + "test" + "</b> <button type='button' name='eee' value = 'eee'></button> "

      # marker.infowindow '<form action="/posts/1" class="button_to" data-remote="true" method="post">
      # <div><input type="submit" value="A post"></div>
      # </form>'
      if user.description == nil
        user.description = ""
      end 
      marker.title user.description
      marker.infowindow '<form action="/map/index" data-remote="true" method="post"><div><textarea name="memo" style="height:5em">'+user.description+'</textarea></div><div><input type="hidden" name="id" value= '+user.id.to_s+' ></div><div><input type="submit" name="add" value="save" onClick="location.reload();"><input type="submit" name="delete" value="delete" onClick="location.reload();"></div></form>'

      # pic_info ={
      #             "url" => 'http://www.planet-action.org/img/2009/interieur/bg_titre_open.png', 
      #             "width" =>  32, 
      #             "height" => 32
      #           }
      # marker.picture pic_info 
      marker.json({title: user.title})
      # marker.json({title: "test"})
      puts "###########################"
      # marker.id id.to_s
    end


  rescue
    binding.pry ;
  end
  end


  #
  # === 地点データ保存用
  #
  def post_memo
    is_double_add = false 
    all_memo = Memo.all ;
    all_memo.each do |m|
    if ( params["lng"].to_f == m.longitude && params["lat"].to_f == m.latitude )
       is_double_add = true 
     end

    end

    if !is_double_add
      if params["add"] != nil #メモの追加
        add_memo(params, session[:user_id]) ;
      elsif params["delete"] != nil
        delete_memo(params)  ;
      end
    end

    # render("/map/index")
    # redirect_to('/')
    # redirect_to(:back)
  end


  #
  # === メモの追加
  #
  def add_memo(params, user_id)
    if params["id"] != "new"  #すでにメモが登録してある場合
      @memo = Memo.find(params["id"])
      @memo.description = params["memo"]
      @memo.save
    else        #新規に登録の場合
      @memo= Memo.new(latitude:params["lat"], longitude:params["lng"], description:params[:memo], user_id:user_id ) ;
      @memo.save
    end
  end

  #
  # === メモの削除
  #
  def delete_memo(params)
      @memo = Memo.find(params["id"])
      @memo.delete
  end

end
