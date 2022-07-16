
r = Random.new
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 1, user_id: 1},
    {stars: r.rand(1..5), comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 1, user_id: 2}
])

puts "Review created"

Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 2, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 2, user_id: 4},
    {stars: r.rand(1..5), comments: "printing and typesetting industry.", product_id: 2, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum  when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 2, user_id: 5}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 3, user_id: 1},
    {stars: r.rand(1..5), comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 3, user_id: 3},
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 3, user_id: 6},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 3, user_id: 8}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 4, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 4, user_id: 6}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 5, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 5, user_id: 7}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 6, user_id: 2},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 6, user_id: 1}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id:7, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 7, user_id: 1}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 8, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 8, user_id: 2}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 9, user_id: 4},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 9, user_id: 5}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 10, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 10, user_id: 5}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 11, user_id: 7},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 11, user_id: 3}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", product_id: 12, user_id: 4},
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 12, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 12, user_id: 2}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 13, user_id: 3},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id:13, user_id: 7}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 14, user_id: 2},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 14, user_id: 6}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 15, user_id: 1},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 15, user_id: 6}
])

puts "Review created"
Review.create!([
    {stars: r.rand(1..5), comments: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", product_id: 16, user_id: 5},
    {stars: r.rand(1..5),comments: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages", product_id: 16, user_id: 2}
])
puts "Review created"

Vote.create!([
  {likes: false, review_id: 1, user_id: 3}
])
puts "Vote created"