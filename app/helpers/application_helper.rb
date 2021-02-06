module ApplicationHelper
  def password_post_link
    post_url = 'https://www.fortyeven.com/blog/2021/02/06/nudging-the-world-towards-stronger-passwords.html'
    link_to 'learn more', post_url, target: '_blank', rel: 'noopener'
  end
end
