module UsersHelper
  def user_text(text)
    return if text.blank?

    raw(email2a(url2a(nl2br(sanitize(text).to_s))))
  end
  # 改行文字をbrタグに置換
  def nl2br(text)
    text.gsub(/\R/) { %Q{<br>} }
  end
  # URLをaタグに置換
  def url2a(text)
    text.gsub(URI.regexp(%w[http https])) { %Q{<a href="#{$&}" target="_blank">#{$&}</a>} }
  end
  # メールアドレスをaタグに置換
  def email2a(text)
    text.gsub(/[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i) { %Q{<a href="mailto:#{$&}">#{$&}</a>} }
  end
end
