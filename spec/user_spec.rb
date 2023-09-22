require 'rails_helper'

RSpec.describe User, type: :model do
  # ...validation tests
  it 'validates presence of name' do
    user = User.new(posts_counter: 0)
    user.valid?

    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'validates posts_counter to be a non-negative integer' do
    user = User.new(name: 'Tom', posts_counter: -1)
    user.valid?

    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  describe '#recent_posts' do
    it 'returns the most recent posts' do
      user = User.create(name: 'John')
      # Create some posts associated with the user
      post1 = user.posts.create(title: 'Post 1', created_at: 2.days.ago)
      post2 = user.posts.create(title: 'Post 2', created_at: 1.day.ago)
      post3 = user.posts.create(title: 'Post 3', created_at: 3.days.ago)

      # Call the recent_posts method
      recent_posts = user.recent_posts(2)

      # Expectations
      expect(recent_posts.count).to eq(2)
      expect(recent_posts).to include(post2)
      expect(recent_posts).to include(post1)
      expect(recent_posts).not_to include(post3)
    end
  end
end
