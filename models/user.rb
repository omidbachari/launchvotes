class User
  # This is a stand in for a database
  @@all = []

  attr_reader :id,
    :uid,
    :provider,
    :email,
    :avatar_url

  def initialize(attributes)
    @id = attributes[:id]
    @uid = attributes[:uid]
    @provider = attributes[:provider]
    @email = attributes[:email]
    @avatar_url = attributes[:avatar_url]
  end

  def self.create(attributes)
    attributes.merge(id: all.length + 1)
    user = self.new(attributes)

    # This is where you would want to store the user in the database rather
    # than the in a global variable
    @@all << user

    user
  end

  def self.all
    # This should query the database for all of the users
    @@all
  end

  def self.find_by_id(id)
    # You would want to use SQL here
    all.find { |user| user.id == id }
  end
end


# [1] pry(#<Sinatra::Application>)> user
# => #<User:0x007f92a432d168
#  @avatar_url="https://avatars.githubusercontent.com/u/5783423?",
#  @email="alexmorgan.am@gmail.com",
#  @id=nil,
#  @provider="github",
#  @uid="5783423">
# [2] pry(#<Sinatra::Application>)> auth
# => {"provider"=>"github",
#  "uid"=>"5783423",
#  "info"=>
#   {"nickname"=>"AlexMorgan",
#    "email"=>"alexmorgan.am@gmail.com",
#    "name"=>"Alex Morgan",
#    "image"=>"https://avatars.githubusercontent.com/u/5783423?",
#    "urls"=>{"GitHub"=>"https://github.com/AlexMorgan", "Blog"=>""}},
#  "credentials"=>
#   {"token"=>"c2f4921d4166a519805ab318e7cbc2716371ce46", "expires"=>false},
#  "extra"=>
#   {"raw_info"=>
#     {"login"=>"AlexMorgan",
#      "id"=>5783423,
#      "avatar_url"=>"https://avatars.githubusercontent.com/u/5783423?",
#      "gravatar_id"=>"20d28e81519b049955d798f81aee34a7",
#      "url"=>"https://api.github.com/users/AlexMorgan",
#      "html_url"=>"https://github.com/AlexMorgan",
#      "followers_url"=>"https://api.github.com/users/AlexMorgan/followers",
#      "following_url"=>
#       "https://api.github.com/users/AlexMorgan/following{/other_user}",
#      "gists_url"=>"https://api.github.com/users/AlexMorgan/gists{/gist_id}",
#      "starred_url"=>
#       "https://api.github.com/users/AlexMorgan/starred{/owner}{/repo}",
#      "subscriptions_url"=>
