module Primitives

using LinearAlgebra, StaticArrays, Printf

include("BasicTypes.jl")
using .BasicTypes


using .BasicTypes
export Vertex, Triangle, Edge
export isInTriangle, isInInCircumcircle, vertexByIndex, contains


mutable struct Vertex <: FieldVector{3,Float64}
    x_::Float64
    y_::Float64
    z_::Float64
end

function Base.show(io::IO, v::Vertex)
    @printf("%f %f %f", v.x_, v.y_, v.z_)
end

mutable struct Edge
    v1_::Vertex
    v2_::Vertex
    isDuplicated_::Bool

    function Edge(v1::Vertex, v2::Vertex)
        this = new()
        this.v1_ = v1
        this.v2_ = v2
        this.isDuplicated_ = false
        return this
    end
end

function Base.show(io::IO, e::Edge)
    @printf("%f %f", e.v1_, e.v2_)
end

mutable struct Triangle
    v1_::Vertex
    v2_::Vertex
    v3_::Vertex
    isBad_::Bool

    function Triangle(v1::Vertex, v2::Vertex, v3::Vertex)
        this = new()
        this.v1_ = v1
        this.v2_ = v2
        this.v3_ = v3
        this.isBad_ = false
        return this
    end

end

function Base.show(io::IO, t::Triangle)
    println("v1: ", t.v1_)
    println("v2: ", t.v2_)
    println("v3: ", t.v3_)
end

function vertexByIndex(t::Triangle, index::Int64)::Vertex
    if index == 1
        return t.v1_
    elseif index == 2
        return t.v2_
    elseif index == 3
        return t.v3_
    else
        @assert false "Invalid index."
    end
end

function contains(t::Triangle, v::Vertex)::Bool
    return  t.v1_ == v || t.v2_ == v || t.v3_ == v;
end

function isInTriangle(v::Vertex, t::Triangle)::Bool
    b = t.v2_ - t.v1_
    c = t.v3_ - t.v1_
    d = v - t.v1_

    det = c.x_ * b.y_ - c.y_ * b.x_
    u = (d.x_ * b.y_ - d.y_ * b.x_) / (det)
    v = (c.x_ * d.y_ - c.y_ * d.x_) / (det)

    return u >= 0 && v >= 0 && u + v < 1
end

function isInInCircumcircle(v::Vertex, t::Triangle)::Bool
    a = t.v1_ - t.v3_
    b = t.v2_ - t.v3_

    z = cross(a, b)
    p0 = cross(dot(a, a) * b - dot(b, b) * a, z) * (0.5 / dot(z, z)) + t.v3_
    r2 = 0.25 * dot(a, a) * dot(b, b) * dot(a - b, a - b) / dot(z, z)

    return dot(v - p0, v - p0) <= r2
end

end