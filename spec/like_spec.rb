require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'methods' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Ruby', text: 'This is my second post', comments_counter: 0, likes_counter: 0)
    like = Like.create(post:, author: user)

    describe '#update_likes_counter' do
      it 'does not update the likes counter if the post is not changed' do
        expect { like.update(updated_at: Time.now) }.not_to(change { post.reload.comments_counter })
      end
    end
  end
end
