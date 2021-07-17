using LinearAlgebra, StaticArrays, Printf, Plots

include("Primitives.jl")
include("BasicTypes.jl")

using .Primitives
using .BasicTypes

mutable struct DelaunayTriangulation
    triangles_::Array{Triangle,1}
    vertices_::Array{Vertex,1}

    function DelaunayTriangulation(vertices::Array{Vertex,1})
        this = new()
        this.triangles_ = Triangle[]
        this.vertices_ = Vertex[]

        maxX::Float64 = typemin(Float64);
        maxY::Float64 = typemin(Float64);
        minX::Float64 = typemax(Float64);
        minY::Float64 = typemax(Float64);

        for vertex in vertices
            maxX = maximum([maxX, vertex.x_])
            maxY = maximum([maxY, vertex.y_])
            minX = minimum([minX, vertex.x_])
            minY = minimum([minY, vertex.y_])
        end

        deltaMax::Float64 = maximum([maxX - minX, maxY - minY ]);
        midDeltaX::Float64 = (minX + maxX) / 2.0;
        midDeltaY::Float64 = (minY + maxY) / 2.0;

        p1::Vertex = Vertex(midDeltaX - 20 * deltaMax, midDeltaY - deltaMax, 0.0);
        p2::Vertex = Vertex(midDeltaX, midDeltaY + 20 * deltaMax, 0.0);
        p3::Vertex = Vertex(midDeltaX + 20 * deltaMax, midDeltaY - deltaMax, 0.0);

        push!(this.triangles_, Triangle(p1, p2, p3));

        for vertex in vertices
            insertVertex(this, vertex)
            println("====================")
        end

        println("length(this.triangles_)....")
        println(length(this.triangles_))

        filter!(t-> !contains(t, p1), this.triangles_)
        filter!(t-> !contains(t, p2), this.triangles_)
        filter!(t-> !contains(t, p3), this.triangles_)

        return this
    end
end

function insertVertex(d::DelaunayTriangulation, v::Vertex)

    polygon = Array{Edge, 1}(undef, 0)

    for oneTriangle in d.triangles_
        if isInInCircumcircle(v, oneTriangle)
            println("found oneTriangle.isBad_!")
            oneTriangle.isBad_ = true
            push!(polygon, Edge(oneTriangle.v1_, oneTriangle.v2_));
            push!(polygon, Edge(oneTriangle.v2_, oneTriangle.v3_));
            push!(polygon, Edge(oneTriangle.v3_, oneTriangle.v1_));
        end
    end

    filter!(t->t.isBad_ == false, d.triangles_)


    for i = 1:length(polygon)
        for j = i+1:length(polygon)
            if((polygon[i].v1_ == polygon[j].v1_ && polygon[i].v2_ == polygon[j].v2_)||
               (polygon[i].v1_ == polygon[j].v2_ && polygon[i].v2_ == polygon[j].v1_))
               println("found! polygon.isDuplicated_")
               polygon[i].isDuplicated_ = true
               polygon[j].isDuplicated_ = true
            end
        end
    end

    filter!(e->e.isDuplicated_ == false, polygon)

    println(length(polygon))

    for oneEdge in polygon
        println("....")

        println(oneEdge.v1_)
        println(oneEdge.v2_)

        push!(d.triangles_, Triangle(oneEdge.v1_, oneEdge.v2_, v));
    end

end

function savePlot(d::DelaunayTriangulation)

    fig = plot([0.0, 0.0], [0.0, 0.0], legend = false)

    for oneTriangle in d.triangles_
        plot!(fig, [oneTriangle.v1_.x_,oneTriangle.v2_.x_,oneTriangle.v3_.x_,oneTriangle.v1_.x_], [oneTriangle.v1_.y_,oneTriangle.v2_.y_,oneTriangle.v3_.y_, oneTriangle.v1_.y_])
    end

    savefig(fig, "output.png")
end

vertices = Array{Vertex,1}(undef, 0)

push!(vertices, Vertex(0.0, 0.0, 0.0))
push!(vertices, Vertex(99.0, 99.0, 0.0))
push!(vertices, Vertex(200.0, 50.0, 0.0))
push!(vertices, Vertex(0.0, 50.0, 0.0))
push!(vertices, Vertex(150.0, 0.0, 0.0))


delaunay= DelaunayTriangulation(vertices)
savePlot(delaunay)

println("done!")


