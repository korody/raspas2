namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_authors
    make_jobs
    make_relationships
    make_origins
    make_genres
    make_raspas
    make_tags
  end
end

def make_authors
  99.times do |n|
    name  = Faker::Name.name
    email = "aprendiz#{n+1}@raspas.com"
    password = "kiwi123"
    profile = UserProfile.create!(email: email, password: password)
    Author.create!(name: name, profile: profile)
  end
end

def make_jobs
  Author.all.each do |author|
    2.times do
      name = Faker::Company.name
      author.jobs.create!(name: name.downcase)
    end
  end
end

def make_relationships
  authors = Author.all
  author  = authors.last
  idols = authors[1..50]
  fans = authors[3..40]
  idols.each { |idol| author.fan!(idol) }
  fans.each { |fan| fan.fan!(author) }
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

def make_genres
  Origin.all.each do |origin|
    2.times do
      name = Faker::Name.last_name
      origin.genres.create!(name: name.downcase)
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