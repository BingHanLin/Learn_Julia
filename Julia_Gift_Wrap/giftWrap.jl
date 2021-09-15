module giftWrap

export point, giftWrapAlgo
struct point
    x_::Float32
    y_::Float32
end

function orientation(p::point, q::point, r::point)::Int32
    val = (q.y_ - p.y_) * (r.x_ - q.x_) -(q.x_ - p.x_) * (r.y_ - q.y_);

    if (val == 0.0) 
        return 0
    elseif (val > 0.0) 
        return 1
    else	
        return 2 
    end
end


function giftWrapAlgo(intputPt::Array{point,1})::Array{Int64,1}
    hull = Int64[]

    startPt = 1
    for i in 1:length(intputPt)-1
        if(intputPt[i+1].x_ < intputPt[i].x_)
            startPt = i+1
        end
    end


    p = startPt
    while true
        push!(hull, p)

        q = mod1(p+1, length(intputPt))
        for i in 1:length(intputPt)

            if (orientation(intputPt[p], intputPt[i], intputPt[q])==2)
                q = i;
            end
        end
        p = q;

        if (p == startPt)
            break
        end
    end

    return hull
end

end
