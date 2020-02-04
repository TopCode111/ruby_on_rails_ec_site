brand_list=['ASSOS', 'Nike', 'GUCCI', 'addidas', 'FENDI', 'VALENTINO', 'Coach']
sizes=['~XS', 'S', 'L', 'M', 'XL~']

brand_list.each do |brand|
  Brand.find_or_create_by(name: brand)
end

sizes.each do |size|
  Size.find_or_create_by(size: size)
end

admin = AdminUser.find_by_email('admin@example.com')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless admin.present?
