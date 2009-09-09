products = []
5.times { products << Factory(:product)}

stories = []
18.times { stories << Factory(:story, :product => products.rand)}

sprints = []
10.times { sprints << Factory(:sprint, :product => products.rand) }

tasks = []
100.times { tasks << Factory(:task, :sprint => sprints.rand, :story => stories.rand) }

