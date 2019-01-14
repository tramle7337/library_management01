module BooksHelper
  def get_authors name
    Author.order name
  end

  def get_publishers name
    Publisher.order name
  end

  def find_users id
    User.find_by id: id
  end

  def get_likes id
    Like.find_by id: id
  end
end
