module Primitives

export Vertex

using LinearAlgebra, StaticArrays, Printf

mutable struct Vertex <: FieldVector{3,Float64}
    x_::Float64
    y_::Float64
    z_::Float64
end

end
