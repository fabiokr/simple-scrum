#generate products
products = []
25.times { products << Factory(:product)}

#generate stories
stories = []
200.times { stories << Factory(:story, :product => products.rand)}

# results
puts "#{products.size} products created"
puts "#{stories.size} stories created"

