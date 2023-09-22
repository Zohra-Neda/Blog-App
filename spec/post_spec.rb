require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it 'requires title to be present' do
      post = Post.new(author: nil, title: '', text: 'This is my first post', comments_counter: 0, likes_counter: 0)

      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'requires title to be maximum 250 characters long' do
      post = Post.new(author: nil, title: 'x' * 251, text: 'This is my second post', comments_counter: 0, likes_counter: 0)

      expect(post.valid?).to be_falsey
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'requires comments_counter to be a non-negative integer' do
      post = Post.new(author: nil, title: 'Java', text: 'This is my third post', comments_counter: -1, likes_counter: 0)

      expect(post.valid?).to be_falsey
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end

    it 'requires likes_counter to be a non-negative integer' do
      post = Post.new(author: nil, title: 'Programming', text: 'This is my fourth post', comments_counter: 0, likes_counter: -1)

      expect(post.valid?).to be_falsey
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
    end
  end

  context 'methods' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)

    describe '#recent_comments' do
      it 'returns the 5 most recent comments' do
        comments = []
        6.times do |i|
          comments << Comment.create(post:, author: user, text: "Comment #{i + 1}")
        end

        expect(post.recent_comments).to eq([comments[-1], comments[-2], comments[-3], comments[-4], comments[-5]])
      end
    end

    describe '#update_posts_counter' do
      it 'does not update the posts counter if the author is not changed' do
        expect { post.update(text: 'Updated Text') }.not_to(change { user.reload.posts_counter })
      end
    end
  end
end
