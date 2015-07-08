class FacebookNetworkController < ApplicationController
  def connect
    oauth = Koala::Facebook::OAuth.new(Facebook::APP_ID , Facebook::SECRET,connect_callback_facebook_url)
    @url_redirect = oauth.url_for_oauth_code(permissions: FacebookNetwork.permissions)
    respond_to :js
  end

  def connect_callback
    return unless handle_user(connect_callback_facebook_url)
    redirect_to :root
  end


  private
    def handle_user(callback)
      if facebook_object = handle_facebook_callback(callback)
        graph = facebook_object[:graph]
        access_token = facebook_object[:access_token]
        profile = graph.get_object("me")
        user = User.find_or_create_with_facebook_account(profile, access_token)
        if user
          sign_in user
        end
        user
      else
        false
      end
    end

    def handle_facebook_callback(callback)
      if (!params[:error].blank? || params[:code].blank?)
        oauth = Koala::Facebook::OAuth.new(Facebook::APP_ID , Facebook::SECRET,callback)
        @url_redirect = oauth.url_for_oauth_code(permissions: FacebookNetwork.permissions)
        render :text => "<script type='text/javascript'>window.open('#{@url_redirect}','_top','menubar=yes,toolbar=yes,location=yes,directories=yes,fullscreen=no,titlebar=yes,hotkeys=yes,status=yes,scrollbars=yes,resizable=yes');</script>", :content_type => "text/html"
        return false
      end
      access_token = Koala::Facebook::OAuth.new(callback).get_access_token(params[:code])

      return { access_token: access_token , graph: Koala::Facebook::API.new(access_token) }
    end
end