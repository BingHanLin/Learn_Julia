include("giftWrap.jl")

using .giftWrap

allPoints = point[]

push!(allPoints, point(0.0, 0.0))
push!(allPoints, point(99.0, 99.0))
push!(allPoints, point(200.0, 50.0))
push!(allPoints, point(200.0, -50.0))

hull = giftWrapAlgo(allPoints)

println(hull)