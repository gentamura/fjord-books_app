require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  setup do
    @new_report = reports(:new_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'write a report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: @new_report.title
    fill_in '内容', with: @new_report.content
    click_on '登録する'

    assert_text '日報が作成されました。'
    click_on '戻る'
  end

  test 'update a report' do
    visit reports_url
    click_on '編集'

    fill_in 'タイトル', with: '更新タイトルテスト'
    fill_in '内容', with: '更新内容テスト'
    click_on '更新する'

    assert_text '更新タイトルテスト'
    assert_text '更新内容テスト'
    assert_text '日報が更新されました。'
    click_on '戻る'
  end

  test 'delete a report' do
    visit reports_url

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
