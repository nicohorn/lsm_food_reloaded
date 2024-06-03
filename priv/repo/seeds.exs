# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LsmFoodReloaded.Repo.insert!(%LsmFoodReloaded.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Faker

# Create 10 businesses
for _ <- 1..10 do
  LsmFoodReloaded.Repo.insert!(%LsmFoodReloaded.Businesses.Business{
    owner: 1,
    name: Faker.Company.name(),
    description: Faker.Lorem.sentence(10..69),
    phone_number: Faker.Phone.EnUs.phone(),
    address: Faker.Address.street_address(),
    socials: Faker.Internet.url(),
    image: Faker.Internet.image_url()
  })
end
