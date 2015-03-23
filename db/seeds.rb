# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

print "* Seeding"

20.times do
  print "."

  body = "# #{Faker::Company.bs.titlecase}\n\n"
  body << "#{Faker::Hacker.phrases.join("\n")}"

  Page.create!(
    title: Faker::Company.catch_phrase,
    revisions: [Revision.new(body: body, engine: "markdown")]
  )
end

puts "Done!"
