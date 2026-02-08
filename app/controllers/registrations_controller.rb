class RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    # Create a new account for the user
    @account = Account.new(
      name: "#{resource.email.split('@').first}'s Account",
      identifier: nil # Will be auto-generated
    )

    # Save the account first
    if @account.save
      # Associate the user with the new account
      resource.account = @account

      # Save the user with the account
      if resource.save
        set_flash_message!(:notice, :signed_up)
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        clean_up_passwords(resource)
        set_minimum_password_length
        respond_with resource
      end
    else
      # Account creation failed, show errors
      clean_up_passwords(resource)
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
