5.times do |n|
    name = "User number " + n.to_s
    email = "user" + n.to_s + "@gmail.com"
    password = "mypassword"
    User.create!(name: name,
                email: email,
                password: password)
end

5.times do |n|
    name = "Categorie " + n.to_s
    Category.create!(name: name)
end

5.times do |n|
    name = "Movie n° " + n.to_s
    description = " Decription of Movie n° "+ n.to_s
    duration = 16 + n
    director = "Originally"
    Movie.create!(name: name, description: description, user_id: 1, category_id:1, duration: duration, director: director)
end

5.times do |n|
    content = "Comment content " + n.to_s
    Comment.create!(content: content, movie_id: 5, user_id: 1)
end

5.times do |n|
    Favorite.create!(movie_id: n+1, user_id: 1)
end

      