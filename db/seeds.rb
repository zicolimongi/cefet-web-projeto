# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Admin.new
admin.email = 'zicolimongi@gmail.com'
admin.password = 'guitarra'
admin.save

20.times do
  Product.create(
      name: "Tênis Preto Nike",
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rerum, deleniti cupiditate autem. Quo provident quos, labore ducimus, quam doloribus alias repudiandae placeat, sunt illum voluptatibus veniam est velit commodi, facere.",
      image_link: "http://g04.a.alicdn.com/kf/HTB1VomoIpXXXXXfXVXXq6xXFXXXM/Sneakers-mulheres-2015-homens-Sneakers-cal%C3%A7ados-esportivos-homens-huarache-zapatos-homens-sapatos-de-cunha-t%C3%AAnis-running.jpg_200x200.jpg",
      price: 199)
end