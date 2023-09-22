require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'methods' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Ruby', text: 'This is my second post', comments_counter: 0, likes_counter: 0)
    comment = Comment.create(post:, author: user, text: 'Hello Tom!')

    describe '#update_comments_counter' do
      it 'does not update the comments counter if the post is not changed' do
        expect { comment.update(text: 'Updated Comment') }.not_to(change { post.reload.likes_counter })
      end
    end
  end
end
