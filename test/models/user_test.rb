# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = User.create!(email: 'alice@example.com', password: 'password')
    @bob = User.create!(email: 'bob@example.com', password: 'password')
  end

  test '#following?' do
    @alice.follow(@bob)
    assert @alice.following?(@bob)
  end

  test '#followed_by?' do
    @alice.follow(@bob)
    assert @bob.followed_by?(@alice)
  end

  test '#follow' do
    assert_not @alice.following?(@bob)

    @alice.follow(@bob)
    assert @alice.following?(@bob)
  end

  test '#unfollow' do
    @alice.follow(@bob)
    assert @alice.following?(@bob)

    @alice.unfollow(@bob)
    assert_not @alice.following?(@bob)
  end

  test '#name_or_email' do
    assert_equal 'alice@example.com', @alice.name_or_email

    @alice.name = 'alice'
    assert_equal 'alice', @alice.name_or_email
  end
end
