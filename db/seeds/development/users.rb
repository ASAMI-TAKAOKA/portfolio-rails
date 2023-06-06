10.times do |n|
  name = "user#{n}"
  email = "#{name}@example.com"
  uid = SecureRandom.uuid # 一意のuidを生成する
  provider = "example" # プロバイダー名を指定する（例: "example"）

  user = User.find_or_initialize_by(uid: uid, provider: provider)

  if user.new_record?
    user.name = name
    user.email = email
    user.password = "password"
    user.activated = true
    user.save!
  end
end

puts "users = #{User.count}"