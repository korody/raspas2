namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_authors
    make_origins
    make_raspas
    make_tags
    # make_users
    # make_relationships
  end
end

def make_authors
  99.times do |n|
    name  = Faker::Name.name
    email = "aprendiz#{n+1}@raspas.com"
    password = "kiwi123"
    Author.create!(name: name, email: email, password: password)
  end
end

def make_origins
  Author.all(limit: 10).each do |author|
    2.times do
      title = Faker::Company.name
      content = Faker::Lorem.sentence(40)
      author.origins.create!(title: title, content: content)
    end
  end
end

def make_raspas
  Author.all(limit: 10).each do |author|
    50.times do
      quote = Faker::Lorem.sentence(10)
      note = Faker::Lorem.sentence(3)
      origin = "1"
      author.raspas.create!(quote: quote, note: note, origin_id: origin)
    end
  end
end

def make_tags
  Raspa.all.each do |raspa|
    3.times do
      name = Faker::Name.last_name
      raspa.tags.create!(name: name.downcase)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end