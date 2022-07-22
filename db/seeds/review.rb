
r = Random.new
[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 1, user_id: 1},
    {stars: r.rand(1..5), comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 1, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 1"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 2, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 2, user_id: 4},
    {stars: r.rand(1..5), comments: "printing and typesetting industry.", product_id: 2, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum  when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 2, user_id: 5}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 2"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 3, user_id: 1},
    {stars: r.rand(1..5), comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 3, user_id: 3},
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 3, user_id: 6},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 3, user_id: 8}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 3"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 4, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 4, user_id: 6}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 4"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 5, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 5, user_id: 7}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 5"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 6, user_id: 2},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 6, user_id: 1}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 6"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id:7, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 7, user_id: 1}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 7"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 8, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 8, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 8"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 9, user_id: 4},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 9, user_id: 5}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 9"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 10, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 10, user_id: 5}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 10"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 11, user_id: 7},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 11, user_id: 3}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 11"

[
    {stars: r.rand(1..5), comments: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", product_id: 12, user_id: 4},
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 12, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 12, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 12"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 13, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id:13, user_id: 7}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 13"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 14, user_id: 2},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 14, user_id: 6}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 14"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 15, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 15, user_id: 6}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 15"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 16, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 16, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 16"

[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 17, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id:17, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 17"
[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 18, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 18, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 18"
[
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 19, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 19, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 19"
[
    {stars: 5, comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 20, user_id: 5},
    {stars: 4,comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 20, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 20"
[
    {stars: 5, comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 21, user_id: 5},
    {stars:5,comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 21, user_id: 2}
].each do |attributes|
    Review.find_or_initialize_by(product_id: attributes[:product_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Review created for product 21"

[
  {likes: false, review_id: 1, user_id: 3}
].each do |attributes|
    Vote.find_or_initialize_by(review_id: attributes[:review_id], user_id: attributes[:user_id],).update!(attributes)
end
puts "Vote created for review 1"