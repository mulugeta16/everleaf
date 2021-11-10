
10.times do |index|
	User.create!(
	    name: Faker::Name.name,
	    email: Faker::Internet.email,
	    password: "password",
	    password_confirmation: "password",
	)
 end

  User.create!( name: "admin",
                 email: "admin@gmail.com",
                 password: "123456",
                 password_confirmation: "123456",
                 admin: true )
10.times do |id|
 Label.create!(
        id: id,
        name: Faker::Verb.past_participle,
    )
end

10.times do |n|
    Labelling.create!(task_id: rand(1..20), label_id: rand(1..3))
 end
