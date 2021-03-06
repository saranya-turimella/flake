Rails.application.routes.draw do


  # Routes for the Plan resource:

  # CREATE
  post("/insert_plan", { :controller => "plans", :action => "create" })
          
  # READ
  get("/plans", { :controller => "plans", :action => "index" })
  
  get("/plans/:path_id", { :controller => "plans", :action => "show" })
  
  # UPDATE
  
  post("/modify_plan/:path_id", { :controller => "plans", :action => "update" })
  
  # DELETE
  get("/delete_plan/:path_id", { :controller => "plans", :action => "destroy" })

  #------------------------------

  #HOMEPAGE WHEN NOT SIGNED IN 
  get("/", {:controller => "user_authentication", :action => "homepage"})

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
