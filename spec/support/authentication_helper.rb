module AuthenticationHelper
  def login_as(user)
    mock_omni_auth_for(user)
    visit '/'
    click_button "Login with GitHub"
  end

  def mock_omni_auth_for(user)
    mock_options = {
      uid: user.uid,
      provider: user.provider,
      info: {
        name: user.name,
        email: user.email,
        image: user.pic_url
      }
    }
    OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
  end
end
