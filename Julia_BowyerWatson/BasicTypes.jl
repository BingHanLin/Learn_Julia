module BasicTypes

export Vec3F, Vec3I

using StaticArrays

const Vec3F = SVector{3,Float64}
const Vec3I = SVector{3,Int64}

end