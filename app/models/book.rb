class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title like?', content + '%')
    elsif method == 'backward'
      Book.where('title Like?', '%' + content)
    else
      Book.where('title Like?', '%' + content + '%')
    end 
  end  
      

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
