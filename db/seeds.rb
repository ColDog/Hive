User.create(name: 'administrator', email: 'admin@admin.com', password: 'password',
            password_confirmation: 'password')
Admin.create(user_id: 1)