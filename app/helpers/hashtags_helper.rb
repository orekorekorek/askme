module HashtagsHelper
  def display_hashtag(hashtag)
    "##{hashtag&.name}"
  end
end
