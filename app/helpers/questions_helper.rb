module QuestionsHelper
  def text_with_hashtag_link(text)
    strip_tags(text).gsub(Question::HASHTAG_REGEXP) { |ht| link_to ht, hashtag_path(ht.delete('#').downcase) }
  end
end
