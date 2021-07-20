# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    alice = User.create!(email: 'alice@example.com', password: 'password')
    bob = User.create!(email: 'bob@example.com', password: 'password')

    report = Report.create!(title: 'report title', content: 'report content', user: alice)

    assert report.editable?(alice)
    assert_not report.editable?(bob)
  end

  test '#created_on' do
    alice = User.create!(email: 'alice@example.com', password: 'password')

    ymd_str = '2021-01-01'
    report = Report.create!(title: 'report title', content: 'report content', user: alice, created_at: Time.new(ymd_str))

    assert_equal Date.parse(ymd_str), report.created_on
  end
end
