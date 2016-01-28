function str2et( dates::Array{ASCIIString,1} )
        ets = Array{Float64}( length(dates) )
    for i = 1:length(dates)
         ets[i] = str2et( dates[i] )
    end
    return ets
end

function cnmfrm( cnames::Array{ASCIIString,1} )
    frcodes = Array{Int32,1}( length(cnames) )
    frnames = Array{String,1}( length(cnames) )
    founds = Array{Bool,1}( length(cnames) )
    for i = 1:length(cnames)
        (frcodes[i], frnames[i], founds[i]) = cnmfrm( cnames[i] )
    end
    return (frcodes, frnames, founds)
end

function bodc2n( codes::Array{Int64,1} )
    names = Array{String,2}( 1, length(codes) )
    founds = Array{Bool,2}( 1, length(codes) )
    for i = 1:length(codes)
        (names[1, i], founds[1, i]) = bodc2n( codes[i] )
    end
    return (names, founds )
end
#

function bodc2s( codes::Array{Int64,1} )
    names = Array{String,1}( length(codes) )
    for i = 1:length(codes)
        names[i] = bodc2s( codes[i] )
    end
    return names
end

function cidfrm( cents::Array{Int64,1} )
    frcodes = Array{Int32,1}( length(cents) )
    frnames = Array{String,1}( length(cents) )
    founds = Array{Bool,1}( length(cents) )
    for i = 1:length(cents)
        (frcodes[i], frnames[i], founds[i]) = cidfrm( cents[i] )
    end
    return (frcodes, frnames, founds)
end

function cnmfrm( cnames::Array{ASCIIString,1} )
    frcodes = Array{Int32,1}( length(cnames) )
    frnames = Array{String,1}( length(cnames) )
    founds = Array{Bool,1}( length(cnames) )
    for i = 1:length(cnames)
        (frcodes[i], frnames[i], founds[i]) = cnmfrm( cnames[i] )
    end
    return (frcodes, frnames, founds)
end

function et2lst(
    ets::Array{Float64}, # SpiceDouble
    body::Int64, # SpiceInt
    lon::Float64, # SpiceDouble
    _type::AbstractString) # Ptr{ConstSpiceChar}
    hrs = Array{Int64,1}( length(ets) )      # Ptr{SpiceInt}
    mns = Array{Int64,1}( length(ets) )   # Ptr{SpiceInt}
    scs = Array{Int64,1}( length(ets) )   # Ptr{SpiceInt}
    times = Array{String,1}( length(ets) )  # Ptr{SpiceChar}
    ampm = Array{String,1}( length(ets) )   # Ptr{SpiceChar}
    for i = 1;length(ets)
        (hrs[i], mns[i], scs[i], times[i], ampm[i]) = et2lst( ets[i], body, lon, _type )
    end
    return (hrs, mns, scs, times, ampms)
end



