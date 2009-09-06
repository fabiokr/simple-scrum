products = []
25.times { products << Factory(:product)}

stories = []
200.times { stories << Factory(:story, :product => products.rand)}

sprints = []
30.times { sprints << Factory(:sprint, :product => products.rand) }

