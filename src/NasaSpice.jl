module NasaSpice

using StrPack

const libNasaSpice = Pkg.dir("NasaSpice", "deps", "libcspice")

# replacement for SpiceEllipse
#The members are:
#    center:     Vector defining ellipse's
#                center.
#    semiMajor:  Vector defining ellipse's
#                semi-major axis.
#    semiMinor:  Vector defining ellipse's
#                semi-minor axis.
#
# The ellipse is the set of points
#   {X:  X =                  center
#              + cos(theta) * semiMajor
#              + sin(theta) * semiMinor,
#    theta in [0, 2*Pi) }
@struct type Ellipse
    center::Array{Float64,1}(3)
    semiMajor::Array{Float64,1}(3)
    semiMinor::Array{Float64,1}(3)
end
Base.convert(::Type{Ellipse}) = Ellipse([0.0,0.0,0.0],[0.0,0.0,0.0],[0.0,0.0,0.0])

function codeForEllipse( phase::AbstractString, name::AbstractString, ctype::AbstractString )
    return code( phase, "Ellipse", name, ctype );
end

#e = NasaSpice.Ellipse( [0.,0.,0.], [0.,0.,0.], [0.,0.,0.] )
#io = IOBuffer()
#StrPack.pack( io, e )
#convert( Ptr{Float64}, convert( Ptr{Void}, pointer(io.data) ) )
#ccall...
#seek(io,0)
#f = StrPack.unpack( io, NasaSpice.Ellipse )

# replacement for SpicePlane
# Plane =
#               {X: <normal,X> = constant}
#  normal:     Vector normal to plane.
#  constant:   Constant of plane equation
@struct type Plane
    normal::Array{Float64,1}(3)
    constant::Float64;
end
Base.convert(::Type{Plane}) = Plane([0.0,0.0,0.0],0.0)
function codeForPlane( phase::AbstractString, name::AbstractString, ctype::AbstractString )
    return code( phase, "Plane", name, ctype );
end


function codeForAbstractString( phase::AbstractString, name::AbstractString, maxLength::Int64 )
    str = Array(AbstractString,0)
    # Array{UInt8}(32)
    if phase == "pack" # convert input structure to stream and pointer
        error("codeForAbstractString does not implement 'pack'")
    elseif phase == "allocate" # allocate output structure, convert to stream and pointer
        str = vcat( str, name * "_array = Array{UInt8}(" * string(maxLength) * ")" )
        str = vcat( str, name * "_ptr = pointer( " * name * "_array )" )
# warning on 63 is really in StrPack.jl @34 STRUCT_REGISTRY
    elseif phase == "unpack"   # convert output structure from stream
        name = replace( name, "_ptr", "")
        str = vcat( str, name * " = bytestring( " * name * "_ptr )" )
    end
    return str
end

function codeForAbstractString256( phase::AbstractString, name::AbstractString, ctype::AbstractString )
    codeForAbstractString( phase, name, 256 )
end



function code( phase::AbstractString, structure::AbstractString, name::AbstractString, ctype::AbstractString )
    str = Array(AbstractString,0)
    if phase == "pack" # convert input structure to stream and pointer
        str = vcat( str, "io" * name * " = IOBuffer()" )
        str = vcat( str, "StrPack.pack( io" * name * ", " * name * ")" )
        str = vcat( str, name * "_ptr = convert( Ptr{" * ctype * "}, convert( Ptr{Void}, pointer(io" * name * ".data) ) )" )
    elseif phase == "allocate" # allocate output structure, convert to stream and pointer
        str = vcat( str, name * " = " * structure * "()" )
        str = vcat( str, "io" * name * " = IOBuffer()" )
        str = vcat( str, "StrPack.pack( io" * name * ", " * name * ")" )
        str = vcat( str, name * "_ptr = convert( Ptr{" * ctype * "}, convert( Ptr{Void}, pointer(io" * name * ".data) ) )" )
    elseif phase == "unpack"   # convert output structure from stream
        name = replace( name, "_ptr", "")
        str = vcat( str, "seek(io" * name * ",0)" )
        str = vcat( str, name * " = StrPack.unpack( io" * name * ", " * structure * " )" )
    end
    return str
end




include("NasaSpiceApi.jl")
include("NasaSpiceApi_vector.jl")
include("NasaSpiceApi_stringOut.jl")

# Hand Conversions


function resetError()
    ccall((:reset_c,libNasaSpice),Void,())
end

function setErrorAction( action::AbstractString )
    ccall((:erract_c,libNasaSpice),Void,(Ptr{UInt8},Int64,Ptr{UInt8}),
    "SET",length(action),action)
end

include("cspice.jl")

## bitstype 64 dflFloat <: FloatingPoint
## Base.convert(::Type{NasaSpice.dflFloat}, x::Integer) = (real(x))
## Base.convert(::Type{NasaSpice.dflFloat}, x::FloatingPoint) = (x)

#Array_6_SpiceDouble(v::SpiceDouble) = Array_6_SpiceDouble(v,v,v,v,v,v)
#Array_6_Array_6_SpiceDouble(v::SpiceDouble) = Array_6_Array_6_SpiceDouble(
#    Array_6_SpiceDouble(v),
#    Array_6_SpiceDouble(v),
#    Array_6_SpiceDouble(v),
#    Array_6_SpiceDouble(v),
#    Array_6_SpiceDouble(v),
#    Array_6_SpiceDouble(v))

## include("SpiceZdf.jl")

## include("SpiceUsr.jl")

##include("/home/don/xf2eul.jl")

function furnsh_c(file::AbstractString)
    ccall((:furnsh_c,libNasaSpice),Void,(Ptr{UInt8},),file)
end


#function # axisar
##       (r::Array{Float64}(3,3)) =   # Array_3_Array_3_SpiceDouble
#    axisar(
#        axis::Array{Float64}, # Array_3_ConstSpiceDouble
#        angle::Float64) # SpiceDouble

##       enforce input array sizes
#    if length(axis) != 3
#        error("Incorrect size for parameter 1")
#    end
##       allocate the output parameters
#    r = Array{Float64}(3,3);  # Array_3_Array_3_SpiceDouble
#    r_ptr = pointer(r)

##       make transposed copies of all input arrays and their pointers
#    axis_t = axis'
#    axis_ptr = pointer(axis_t)

#    ccall((:axisar_c,libNasaSpice),Void,
#        (Ptr{Float64},Float64,Ptr{Float64}),
#        axis_ptr,angle,r_ptr)

#    return (r')
#end


#function str2et( date::AbstractString )
#    et = Array(SpiceDouble,1)
#    ccall((:str2et_c,libNasaSpice),Void,(Ptr{ConstSpiceChar},Ptr{SpiceDouble}),
#                date,
#                et )
#    return convert(Float64, et[1] )
#end


#function sxform( from::AbstractString, to::AbstractString, et::Float64 )
#    xform = zeros(SpiceDouble, 6, 6);
#    xformPtr = convert(Ptr{SpiceDouble}, pointer(xform))
#    et_c = convert(SpiceDouble, et );

#    ccall((:sxform_c,libNasaSpice),Void,(Ptr{ConstSpiceChar},Ptr{ConstSpiceChar},SpiceDouble,Ptr{SpiceDouble}),
#        from,
#        to,
#        et_c,
#        xformPtr )
#    return xform' # TODO remove this an transposes in C wrappers
#end


function __init__()
    setErrorAction( "REPORT" )
end

end
