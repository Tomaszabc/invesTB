module CommentsHelper
  def can_delete_comment?(comment)
    return true if user_signed_in? && comment.user == current_user
    return true if session[:comment_ids]&.include?(comment.id)

    false
  end
end
