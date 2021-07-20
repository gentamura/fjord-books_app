# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
  end

  test '#editable?' do
    bob = users(:bob)
    report = Report.create!(title: 'report title', content: 'report content', user: @alice)

    assert report.editable?(@alice)
    assert_not report.editable?(bob)
  end

  test '#created_on' do
    ymd_str = '2021-01-01'
    report = Report.create!(title: 'report title', content: 'report content', user: @alice, created_at: Time.zone.local(ymd_str))

    assert_equal Date.parse(ymd_str), report.created_on
  end
end
