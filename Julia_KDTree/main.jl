include("KDTreeModel.jl")

using .KDTreeModel

nodes = [Vertex(0.1,1.1,0.0),Vertex(0.2,0.7,1.0),Vertex(0.3,1.0,1.0),Vertex(1.0,0.6,1.1),Vertex(0.5,0.3,1.0)]

model = KDTree(nodes)

traverseTree(model.rootNode_)

bestDis = nearestDistance(Vertex(0.1,1.102,0.0), model.rootNode_)

println(bestDis)