module SignInSupport
  def sign_in_shop(shop)
    visit root_path
    expect(find(".load-modal-close").click)
    visit new_shop_session_path
    fill_in 'メールアドレス', with: shop.email
    fill_in 'パスワード', with: shop.password
    find('input[name="commit"]').click
  end

  def sign_in_user(user)
      visit root_path
      expect(find(".load-modal-close").click)
      visit new_user_session_path
      fill_in 'メールアドレス',with:user.email
      fill_in 'パスワード',with:user.password
      find('input[name="commit"]').click
  end
end