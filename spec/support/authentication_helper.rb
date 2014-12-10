module AuthenticationHelper
  def login_as(user)
    mock_omni_auth_for(user)
    visit "/auth/#{user.provider}"
    expect(page).to have_content("You have signed in as #{user.display_name}")
  end

  def mock_omni_auth_for(user)
    mock_options = {
      uid: user.uid,
      provider: user.provider,
      info: {
        name: user.name,
        nickname: user.username,
        email: user.email,
        image: user.pic_url
      },
      credentials: {
        token: user.github_token
      }
    }
    OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
  end
end
