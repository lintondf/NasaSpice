################################################################################
#                                    #####
#    #####    ####   #####    ####  #     #  #    #
#    #    #  #    #  #    #  #    #       #  ##   #
#    #####   #    #  #    #  #       #####   # #  #
#    #    #  #    #  #    #  #      #        #  # #
#    #    #  #    #  #    #  #    # #        #   ##
#    #####    ####   #####    ####  #######  #    #
#
#   body id code to name
#
################################################################################
#-Abstract
#
#   bodc2n returns the body name corresponding to an input numeric
#   ID value.
#
#-I/O
#
#   Given:
#
#      code   an integer scalar or integer 1XN array of SPICE codes
#             for a set of bodies: planets, satellites, barycenters,
#             DSN stations, spacecraft, asteroids, comets, or other
#             ephemeris object.
#
#   the call:
#
#      [name, found] = bodc2n( code )
#
#   returns:
#
#      name    the scalar string or NXM character array of names associated
#              with 'code' (if 'code' has more than one translation, then
#              the most recently defined name corresponding to 'code'
#              is returned).
#
#      found   a boolean scalar or boolean 1XN array flagging if the kernel
#              subsystem translated 'code' to a corresponding name.
#
#              'found' and 'name' return with the same vectorization
#              measure (N) as 'code'.
#
#-Particulars
#
#   A sister version of this routine exists named mice_bodc2n that returns
#   the output arguments as fields in a single structure.
#
#   bodc2n is one of five related subroutines,
#
#      cspice_bods2c      Body string to code
#      cspice_bodc2s      Body code to string
#      cspice_bodn2c      Body name to code
#      bodc2n      Body code to name
#      cspice_boddef      Body name/code definition
#
#   cspice_bods2c, cspice_bodc2s, cspice_bodn2c, and bodc2n
#   perform translations between body names and their corresponding
#   integer ID codes which are used in SPICE files and routines.
#
#   cspice_bods2c is a slightly more general version of cspice_bodn2c:
#   support for strings containing ID codes in string format enables a caller
#   to identify a body using a string, even when no name is associated with
#   that body.
#
#   cspice_bodc2s is a general version of bodc2n; the routine returns
#   either the name assigned in the body ID to name mapping or a string
#   representation of the 'code' value if no mapping exists.
#
#   cspice_boddef assigns a body name to ID mapping. The mapping has
#   priority in name-to-ID and ID-to-name translations.
#
#   Refer to NAIF_IDS.REQ for the list of name/code associations built
#   into SPICE, and for details concerning adding new name/code
#   associations at run time by loading text kernels.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine bodc2n_c.
#
#   MICE.REQ
#   NAIF_IDS.REQ
#
    function # bodc2n
#       (name::AbstractString,  # Ptr{SpiceChar}
#        found::Int32) =   # Ptr{SpiceBoolean}
        bodc2n(
            code::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        name_array = Array{UInt8}(256)
        name_ptr = pointer( name_array )
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:bodc2n_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceInt,Ptr{SpiceChar},Ptr{SpiceBoolean}),code,namelen,name,found)
        ccall((:bodc2n_c,libNasaSpice),Void,
            (Int64,Int64,Ptr{SpiceChar},Ptr{Int32}),
            code,255,name_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        name = bytestring( name_ptr )
        return (name, convert( Bool, found[1] ))
    end

    function bodc2n( codes::Array{Int64,1} )
        names = Array{AbstractString,2}( 1, length(codes) )
        founds = Array{Bool,2}( 1, length(codes) )
        for i = 1:length(codes)
            (names[1, i], founds[1, i]) = bodc2n( codes[i] )
        end
        return (names, founds )
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Retrieve the current body name associated to a given NAIF ID.
#      %
#      disp( 'Scalar:' )
#      naif_id = 501;
#      [name, found] = bodc2n( naif_id );
#
#      %
#      % Output the mapping if it exists.
#      %
#      if ( found )
#         fprintf( 'Body ID %i maps to name %s\n', naif_id, name );
#      end
#
#      disp( ' ' )
#
#      %
#      % Create an array of IDs. Include one unknown ID.
#      %
#      disp( 'Vector:' )
#      naif_id       = [ 502, 503, 504, 505, 5006 ];
#      [name, found] = bodc2n( naif_id );
#
#      n_elements = size(found,2);
#
#      %
#      % Loop over the output array.
#      %
#      for n=1:n_elements
#
#         %
#         % Check for a valid name/ID mapping.
#         %
#         if( found(n) )
#            fprintf( 'Body ID %i maps to name %s\n', ...
#                           naif_id(n) , name(n,:) );
#         else
#            fprintf( 'Unknown body ID %i\n', naif_id(n) );
#         end
#
#      end
#
#   MATLAB outputs:
#
#      Scalar:
#      Body ID 501 maps to name IO
#
#      Vector:
#      Body ID 502 maps to name EUROPA
#      Body ID 503 maps to name GANYMEDE
#      Body ID 504 maps to name CALLISTO
#      Body ID 505 maps to name AMALTHEA
#      Unknown body ID 5006
#
#-Version
#
#   -Mice Version 1.0.1, 16-MAY-2009 (EDW)
#
#       Edit to Particulars section to document the cspice_bodc2s routine.
#       Extended argument descriptions in the I/O section.
#
#       Corrected typo in usage string.
#
#   -Mice Version 1.0.0, 22-NOV-2005, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#                                    #####
#    #####    ####   #####    ####  #     #   ####
#    #    #  #    #  #    #  #    #       #  #
#    #####   #    #  #    #  #       #####    ####
#    #    #  #    #  #    #  #      #             #
#    #    #  #    #  #    #  #    # #        #    #
#    #####    ####   #####    ####  #######   ####
#
#   body id code to string
#
################################################################################
#-Abstract
#
#   bodc2s translates a body ID code to either the corresponding name
#   or if no name to ID code mapping exists, the string representation of
#   the body ID value.
#
#-I/O
#
#   Given:
#
#      code   an integer scalar or integer 1XN array of SPICE ID codes
#             for a body: planet, satellite, barycenter, spacecraft,
#             asteroid, comet, or other ephemeris object.
#
#   the call:
#
#      [name] = bodc2s( code )
#
#   returns:
#
#      name   the scalar string or NXM character array of names of the
#             bodies identified by 'code' if a mapping between 'code' and
#             a body name exists within SPICE.
#
#             If 'code' has more than one translation, then the most recently
#             defined 'name' corresponding to 'code' is returned. 'name' will
#             have the exact format (case and blanks) as when the name/code pair
#             was defined.
#
#             If the input value of 'code' does not map to a body name, 'name'
#             returns with the string representation of 'code'.
#
#             'name' returns with the same vectorization measure (N) as 'code'.
#
#-Particulars
#
#   A sister version of this routine exists named mice_bodc2n that returns
#   the output arguments as fields in a single structure.
#
#   cspice_bodc2n is one of five related subroutines,
#
#      cspice_bods2c      Body string to code
#      bodc2s      Body code to string
#      cspice_bodn2c      Body name to code
#      cspice_bodc2n      Body code to name
#      cspice_boddef      Body name/code definition
#
#   cspice_bods2c, bodc2s, cspice_bodn2c, and cspice_bodc2n
#   perform translations between body names and their corresponding
#   integer ID codes which are used in SPICE files and routines.
#
#   cspice_bods2c is a slightly more general version of cspice_bodn2c:
#   support for strings containing ID codes in string format enables a caller
#   to identify a body using a string, even when no name is associated with
#   that body.
#
#   bodc2s is a general version of cspice_bodc2n; the routine returns
#   either the name assigned in the body ID to name mapping or a string
#   representation of the 'code' value if no mapping exists.
#
#   cspice_boddef assigns a body name to ID mapping. The mapping has
#   priority in name-to-ID and ID-to-name translations.
#
#   Refer to NAIF_IDS.REQ for the list of name/code associations built
#   into SPICE, and for details concerning adding new name/code
#   associations at run time by loading text kernels.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine bodc2s_c.
#
#   MICE.REQ
#   NAIF_IDS.REQ
#
    function # bodc2s
#       (name::AbstractString) =   # Ptr{SpiceChar}
        bodc2s(
            code::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        name_array = Array{UInt8}(256)
        name_ptr = pointer( name_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:bodc2s_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceInt,Ptr{SpiceChar}),code,lenout,name)
        ccall((:bodc2s_c,libNasaSpice),Void,
            (Int64,Int64,Ptr{SpiceChar}),
            code,255,name_ptr)

#       unpack any structures and transpose back any returned arrays
        name = bytestring( name_ptr )
        return (name)
    end

#    function bodc2s( Array{Int64,1} codes )
#        names = Array{AbstractString,1}( length(codes) )
#        for i = 1:length(codes)
#            names[i] = bodc2s( codes[i] )
#        end
#        return names
#    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Assign an array of body ID codes. Not all the listed codes
#      % map to a body name.
#      %
#      code = [ 399, 0, 3, -77, 11, -1, 6000001 ];
#
#      name = bodc2s( code );
#
#      for i=1:7
#         fprintf( '%8d  %s\n', code(i), name(i,:) )
#      end
#
#   MATLAB outputs:
#
#          399  EARTH
#            0  SOLAR SYSTEM BARYCENTER
#            3  EARTH BARYCENTER
#          -77  GALILEO ORBITER
#           11  11
#           -1  GEOTAIL
#      6000001  6000001
#
#-Version
#
#   -Mice Version 1.0.0, 01-JUN-2009, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####      #    #####   ######  #####   #    #
#    #    #     #    #    #  #       #    #  ##  ##
#    #          #    #    #  #####   #    #  # ## #
#    #          #    #    #  #       #####   #    #
#    #    #     #    #    #  #       #   #   #    #
#     ####      #    #####   #       #    #  #    #
#
#   Fetch reference frame attributes
#
################################################################################
#-Abstract
#
#   cidfrm retrieves the ID code and name of the preferred
#   frame associated with a given body ID.
#
#-I/O
#
#   Given:
#
#      cent   NAIF ID of a body for which a preferred reference frame
#             exists.
#
#             [1,n] = size(cent); int32 = class(cent)
#
#   the call:
#
#      [ frcode, frname, found] = cidfrm(cent)
#
#   returns:
#
#
#      frcode   the SPICE frame code(s) associated with 'cent'.
#
#               [1,n] = size(frcode); int32 = class(frcode)
#
#      frname   the name(s) corresponding to 'frcode'.
#
#               [n,m] = size(frname); char = class(frname)
#
#      found    the flag(s) indicating if the appropriate frame ID-code and
#               frame name can be determined from 'cent'.
#
#               [1,n] = size(found); logical = class(found)
#
#               'frcode', 'frname', and 'found' return with the same
#               vectorization measure (N) as 'cent'.
#
#-Particulars
#
#   This routine allows the user to determine the frame that should
#   be associated with a particular object. For example, if you
#   need the frame name and ID associated with Io, you can call
#   cidfrm to return these values.
#
#   The preferred frame to use with an object is specified via one
#   of the kernel pool variables:
#
#       OBJECT_<cent>_FRAME
#
#   where <cent> is the NAIF ID or name of the object.
#
#   For those objects that have "built-in" frame names this
#   routine returns the corresponding "IAU" frame and frame ID code.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine cidfrm_c.
#
#   MICE.REQ
#   FRAMES.REQ
#
    function # cidfrm
#       (frcode::Int64,  # Ptr{SpiceInt}
#        frname::AbstractString,  # Ptr{SpiceChar}
#        found::Int32) =   # Ptr{SpiceBoolean}
        cidfrm(
            cent::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        frcode = Array{Int64}(1);  # Ptr{SpiceInt}
        frcode_ptr = pointer(frcode)
        frname_array = Array{UInt8}(256)
        frname_ptr = pointer( frname_array )
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:cidfrm_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceInt,Ptr{SpiceInt},Ptr{SpiceChar},Ptr{SpiceBoolean}),cent,lenout,frcode,frname,found)
        ccall((:cidfrm_c,libNasaSpice),Void,
            (Int64,Int64,Ptr{Int64},Ptr{SpiceChar},Ptr{Int32}),
            cent,255,frcode_ptr,frname_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        frname = bytestring( frname_ptr )
        return (frcode[1], frname, convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Retrieve frame information for body ID 501.
#      %
#      disp('Scalar' )
#
#      bodies = 501;
#      [ frcode, frname, found ] = cidfrm( bodies );
#
#      if ( found )
#         fprintf( '%8d  %8d  %s\n', bodies, frcode, frname )
#      end
#
#      %
#      % Retrieve frame information for a vector of body IDs.
#      %
#      disp('Vector' )
#
#      bodies = [ 0, 301, 401, -501 ];
#
#      [ frcode, frname, found ] = cidfrm( bodies );
#
#      for i=1:numel( bodies)
#
#         if ( found(i) )
#            fprintf( '%8d  %8d  %s\n', bodies(i), frcode(i), frname(i,:) )
#         else
#            fprintf( 'No frame associated with ID %d\n', bodies(i) )
#         end
#
#      end
#
#   MATLAB outputs:
#
#      Scalar
#           501     10023  IAU_IO
#
#      Vector
#             0        15  DE-202
#           301     10020  IAU_MOON
#           401     10021  IAU_PHOBOS
#      No frame associated with ID -501
#
#-Version
#
#   -Mice Version 1.0.0, 11-NOV-2013, EDW (JPL), SCK (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####   #    #  #    #  ######  #####   #    #
#    #    #  ##   #  ##  ##  #       #    #  ##  ##
#    #       # #  #  # ## #  #####   #    #  # ## #
#    #       #  # #  #    #  #       #####   #    #
#    #    #  #   ##  #    #  #       #   #   #    #
#     ####   #    #  #    #  #       #    #  #    #
#
#   Fetch reference frame attributes
#
################################################################################
#-Abstract
#
#   cnmfrm retrieves the ID code and name of the preferred
#   frame associated with a given body name.
#
#-I/O
#
#   Given:
#
#      cname   the name(s) of an object for which a preferred reference frame
#              exists.
#
#              [n,m] = size(cname); char = class(cname)
#
#                  or
#
#              [1,n] = size(cname); cell = class(cname)
#
#   the call:
#
#      [ frcode, frname, found] = cnmfrm(cname)
#
#   returns:
#
#      frcode   the SPICE frame code(s) associated with 'cname'.
#
#               [1,n] = size(frcode); int32 = class(frcode)
#
#      frname   the name(s) corresponding to 'frcode'.
#
#               [n,m] = size(frname); char = class(frname)
#
#      found    the flag(s) indicating if the appropriate frame ID-code and
#               frame name can be determined from 'cname'.
#
#               [1,n] = size(found); logical = class(found)
#
#               'frcode', 'frname', and 'found' return with the same
#               vectorization measure (N) as 'cname'.
#
#-Particulars
#
#   This routine allows the user to determine the frame that should
#   be associated with a particular object. For example, if you
#   need the frame name and ID associated with Io, you can call
#   cnmfrm to return these values.
#
#   The preferred frame to use with an object is specified via one
#   of the kernel pool variables:
#
#       OBJECT_<cname>_FRAME
#
#   where <cname> is the NAIF ID or name of the object.
#
#   For those objects that have "built-in" frame names this
#   routine returns the corresponding "IAU" frame and frame ID code.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine cnmfrm_c.
#
#   MICE.REQ
#   FRAMES.REQ
#
    function # cnmfrm
#       (frcode::Int64,  # Ptr{SpiceInt}
#        frname::AbstractString,  # Ptr{SpiceChar}
#        found::Int32) =   # Ptr{SpiceBoolean}
        cnmfrm(
            cname::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        frcode = Array{Int64}(1);  # Ptr{SpiceInt}
        frcode_ptr = pointer(frcode)
        frname_array = Array{UInt8}(256)
        frname_ptr = pointer( frname_array )
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:cnmfrm_c,"/home/don/.julia/v0.3/cspice.so"),Void,(Ptr{ConstSpiceChar},SpiceInt,Ptr{SpiceInt},Ptr{SpiceChar},Ptr{SpiceBoolean}),cname,lenout,frcode,frname,found)
        ccall((:cnmfrm_c,libNasaSpice),Void,
            (Ptr{UInt8},Int64,Ptr{Int64},Ptr{SpiceChar},Ptr{Int32}),
            cname,255,frcode_ptr,frname_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        frname = bytestring( frname_ptr )
        return (frcode[1], frname, convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Return the body frame code and name for Io.
#      %
#
#      [ frcode, frname, found ] = cnmfrm( 'IO' );
#
#      if ( found )
#         fprintf( '%d  %s\n', frcode, frname )
#      end
#
#
#      %
#      % Return the body frame code and name for a vector of body names.
#      %
#
#      bodies = {'EARTH', 'MOON', 'HALO_DELTA'};
#
#      [ frcode, frname, found ] = cnmfrm( bodies );
#
#      for i=1:numel( bodies)
#
#         if ( found(i) )
#            fprintf( '%d  %s\n', frcode(i), frname(i,:) )
#         else
#            fprintf( 'No frame associated with body %s\n', char(bodies(i)) )
#         end
#
#      end
#
#   MATLAB outputs:
#
#      10023  IAU_IO
#      10013  IAU_EARTH
#      10020  IAU_MOON
#      No frame associated with body HALO_DELTA
#
#-Version
#
#   -Mice Version 1.0.0, 11-NOV-2013, EDW (JPL), SCK (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    #####     ##    ######   ####   #    #
#    #    #   #  #   #       #    #  ##   #
#    #    #  #    #  #####   #       # #  #
#    #    #  ######  #       #  ###  #  # #
#    #    #  #    #  #       #    #  #   ##
#    #####   #    #  #        ####   #    #
#
#   get DAF array name
#
################################################################################
#-Abstract
#
#   dafgn returns the name for current array in the current
#   DAF being searched
#
#-I/O
#
#   Given:
#
#      None.
#
#   the call:
#
#      name = dafgn
#
#   returns:
#
#      name     the name of the current DAF array - that array
#               found by a previous call to cspice_daffna or cspice_daffpa.
#
#               [1,c1] = size(name); char = class(name)
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine dafgn_c.
#
#   MICE.REQ
#   DAF.REQ
#
    function # dafgn
#       (name::AbstractString) =   # Ptr{SpiceChar}
        dafgn()

#       enforce input array sizes
#       allocate the output parameters
        name_array = Array{UInt8}(256)
        name_ptr = pointer( name_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:dafgn_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,Ptr{SpiceChar}),lenout,name)
        ccall((:dafgn_c,libNasaSpice),Void,
            (Int64,Ptr{SpiceChar}),
            255,name_ptr)

#       unpack any structures and transpose back any returned arrays
        name = bytestring( name_ptr )
        return (name)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#
#      %
#      % Define a DAF from which to read the name for each array in
#      % the DAF.
#      %
#      DAF = 'daftest.bsp';
#      NI  = 6;
#      ND  = 2;
#
#      %
#      % Open the DAF for read
#      %
#      handle = cspice_dafopr( DAF );
#
#      %
#      % Begin a forward search on 'DAF'.
#      %
#      cspice_dafbfs( handle )
#      found = cspice_daffna;
#
#      %
#      % Loop while found
#      %
#      while ( found )
#
#         [dc, ic] = cspice_dafgs( ND, NI );
#         name = dafgn;
#
#         %
#         % Output each array name.
#         %
#         fprintf( '%s\n', name)
#
#         %
#         % Check for a next segment.
#         %
#         found = cspice_daffna;
#
#      end
#
#      %
#      % SAFELY close the file.
#      %
#      cspice_dafcls( handle )
#
#   MATLAB outputs:
#
#      PHOENIX SPACECRAFT
#      MERCURY BARYCENTER
#      VENUS BARYCENTER
#      EARTH BARYCENTER
#
#         ...
#
#      CANBERRA
#      MADRID
#      PHOBOS BASECAMP
#      TRANQUILITY BASE
#
#-Version
#
#   -Mice Version 1.0.0, 11-JUN-2013, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    ######  #    #  ######     #    #    #  #####
#    #       #   #   #          #    ##   #  #    #
#    #####   ####    #####      #    # #  #  #    #
#    #       #  #    #          #    #  # #  #    #
#    #       #   #   #          #    #   ##  #    #
#    ######  #    #  #          #    #    #  #####
#
#   find EK data
#   issue EK query
#
################################################################################
#-Abstract
#
#   ekfind finds E-kernel data that satisfy a set of constraints.
#
#-I/O
#
#   Given:
#
#      query   a string scalar specifying the data to locate from data
#              available in all loaded EK files. The general form of a
#              query general form:
#
#                 SELECT   <column list>
#                 FROM     <table list>
#                 [WHERE    <constraint list>]
#                 [ORDER BY <ORDER BY column list>]
#
#              (WHERE and ORDER BY are optional parameters)
#
#   the call:
#
#      [ nmrows, ok, errmsg] = ekfind( query )
#
#   returns:
#
#      nmrows   a scalar integer containing the number of rows matching
#               the query.
#
#      ok       a scalar boolean indicating whether the query parsed
#               correctly (TRUE) or not (FALSE).
#
#      errmsg   a string scalar containing a description of the parse
#               error should one occur, otherwise the string returns
#               as blank.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine ekfind_c.
#
#   MICE.REQ
#   EK.REQ
#
    function # ekfind
#       (nmrows::Int64,  # Ptr{SpiceInt}
#        error::Int32,  # Ptr{SpiceBoolean}
#        errmsg::AbstractString) =   # Ptr{SpiceChar}
        ekfind(
            query::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        nmrows = Array{Int64}(1);  # Ptr{SpiceInt}
        nmrows_ptr = pointer(nmrows)
        error = Array{Int32}(1);  # Ptr{SpiceBoolean}
        error_ptr = pointer(error)
        errmsg_array = Array{UInt8}(256)
        errmsg_ptr = pointer( errmsg_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:ekfind_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(Ptr{ConstSpiceChar},SpiceInt,Ptr{SpiceInt},Ptr{SpiceBoolean},Ptr{SpiceChar}),query,lenout,nmrows,error,errmsg)
        ccall((:ekfind_c,libNasaSpice),Void,
            (Ptr{UInt8},Int64,Ptr{Int64},Ptr{Int32},Ptr{SpiceChar}),
            query,255,nmrows_ptr,error_ptr,errmsg_ptr)

#       unpack any structures and transpose back any returned arrays
        errmsg = bytestring( errmsg_ptr )
        return (nmrows[1], convert( Bool, error[1] ), errmsg)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Assign an EK file to load.
#      %
#      EK = 'test_file.ek';
#
#      %
#      % Load the EK.
#      %
#      cspice_furnsh( EK )
#
#      %
#      % Assume the file test_file.ek contains the table 'scalar_2',
#      % and that "scalar_2' contains columns named:
#      %
#      %   c_col_1, d_col_1, i_col_1, t_col_1
#      %
#      % Define a set of constraints to perform a query on all
#      % loaded EK files (the SELECT clause).
#      %
#      query = [ 'Select c_col_1, d_col_1, i_col_1, t_col_1 from ' ...
#                'scalar_2 order by row_no' ];
#
#      %
#      % Query the EK system for data rows matching the
#      % SELECT constraints.
#      %
#      [ nmrows, ok, errmsg ] = ekfind( query );
#
#      %
#      % Check whether an error occurred while processing the
#      % SELECT clause. If so, output the error message.
#      %
#      if ( ok )
#         printf( 'SELECT clause error: %s\n', errmsg );
#      end
#
#      %
#      % If no error occurred, 'nmrows' contains the number of rows matching
#      % the constraints specified in the query string.
#      %
#      fprintf( 'Number of matching row: %d\n', nmrows )
#
#      %
#      % Clear the kernel pool and database. Note, you don't normally
#      % unload an EK after a query, rather at the end of a program.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Number of matching row: 20
#
#   Load at least one EK kernel prior to calling ekfind, otherwise
#   an error signals.
#
#-Version
#
#   -Mice Version 1.2.0, 10-MAY-2011, EDW (JPL)
#
#      "logical" call replaced with "zzmice_logical."
#
#   -Mice Version 1.0.0, 10-APR-2010, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    ######  #    #   ####    ####
#    #       #   #   #    #  #    #
#    #####   ####    #       #
#    #       #  #    #  ###  #
#    #       #   #   #    #  #    #
#    ######  #    #   ####    ####
#
#   fetch element from character column entry
#
################################################################################
#-Abstract
#
#   CSPICE__EKGC returns an element of string (character) data from a
#   specified row in a specified column of the set of rows matching
#   the previous cspice_ekfind SELECT query.
#
#-I/O
#
#   Given:
#
#      selidx   the scalar integer index for a column of interest
#               satisfying the SELECT clause, the column indices
#               range from 1 to number of columns in the SELECT clause.
#
#      row      the scalar integer index for a row in the column
#               identified by 'selidx', the column indices
#               range from 1 to 'nmrows' where 'nmrows' equals the total
#               number of rows satisfying the SELECT clause.
#
#      elment   the scalar integer index for an element of
#               the data at the 'selidx','row' position; a scalar
#               value at 'selidx', 'row' has 'elment' value one.
#
#      lenout   the scalar integer defining the maximum length of the
#               'cdata' output string
#
#   the call:
#
#      [ cdata, null, found] = ekgc( selidx, row, elment, lenout )
#
#   returns:
#
#      cdata    the string value of the requested element at
#               data location 'selidx', 'row', 'elment'.
#
#      null     a scalar boolean indicating if 'idata' has a null value.
#
#      found    a scalar boolean indicating whether the specified
#               value at 'selidx', 'row', 'elment' was found.
#
#-Particulars
#
#   Suppose a SELECT clause return data consisting of three columns (N=3)
#   and four rows (M=4):
#
#              col 1    col 2    col 3
#
#      row 1   val_11   val_12   val_13
#      row 2   val_21   val_22   val_23
#      row 3   val_31   val_32   val_33
#      row 4   val_41   val_42   val_43
#
#   with "col 2" and "col 3" containing scalar string data and
#   "val_42" containing a vector of K strings.
#
#   Retrieving the data elements depends on the values for the index set
#   "selidx," "row," and "elment."
#
#   Use the set
#
#      'selidx' = 2, 'row' = 3, 'elment' = 1
#
#   to fetch scalar "val_32."
#
#   Use the set
#
#      'selidx' = 3, 'row' = 4, 'elment' = 1
#
#   to fetch scalar "val_43."
#
#   Use the set
#
#      'selidx' = 2, 'row' = 4, 'elment' = K
#
#   to fetch the final element of vector "val_42"
#
#   'elment' is allowed to exceed the number of elements in the column
#   entry; if it does, 'found' returns as false.  This allows the caller
#   to read data from the column entry in a loop without checking the
#   number of available elements first.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine ekgc_c.
#
#   MICE.REQ
#   EK.REQ
#
    function # ekgc
#       (cdata::AbstractString,  # Ptr{SpiceChar}
#        null::Int32,  # Ptr{SpiceBoolean}
#        found::Int32) =   # Ptr{SpiceBoolean}
        ekgc(
            selidx::Int64, # SpiceInt
            row::Int64, # SpiceInt
            elment::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        cdata_array = Array{UInt8}(256)
        cdata_ptr = pointer( cdata_array )
        null = Array{Int32}(1);  # Ptr{SpiceBoolean}
        null_ptr = pointer(null)
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:ekgc_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(SpiceInt,SpiceInt,SpiceInt,SpiceInt,Ptr{SpiceChar},Ptr{SpiceBoolean},Ptr{SpiceBoolean}),selidx,row,elment,lenout,cdata,null,found)
        ccall((:ekgc_c,libNasaSpice),Void,
            (Int64,Int64,Int64,Int64,Ptr{SpiceChar},Ptr{Int32},Ptr{Int32}),
            selidx,row,elment,255,cdata_ptr,null_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        cdata = bytestring( cdata_ptr )
        return (cdata, convert( Bool, null[1] ), convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Assign an EK file to load and a max string size
#      % for the ekgc return string.
#      %
#      EK     = 'test_file.ek';
#      MAXSTR = 1025;
#
#      %
#      % Load the EK.
#      %
#      cspice_furnsh( EK )
#
#      %
#      % Assume the file test_file.ek contains the table 'scalar_2',
#      % and that "scalar_2' has the column named 'c_col_1' of scalar
#      % strings.
#      %
#      % Define a set of constraints to perform a query on all
#      % loaded EK files (the SELECT clause). In this case select
#      % the column "c_col_1" from table "scalar_2."
#      %
#      query = 'Select c_col_1 from scalar_2 order by row_no';
#
#      %
#      % Query the EK system for data rows matching the
#      % SELECT constraints.
#      %
#      [ nmrows, ok, errmsg ] = cspice_ekfind( query );
#
#      %
#      % Check whether an error occurred while processing the
#      % SELECT clause. If so, output the error message.
#      %
#      if ( ok )
#         printf( 'SELECT clause error: %s\n', errmsg );
#      end
#
#      %
#      % Loop over each row found matching the query.
#      %
#      for rowno = 1:nmrows
#
#         %
#         % Fetch the character data. We know the query returned
#         % one column and the column contains only scalar data,
#         % so the index of all elements is 1.
#         %
#         selidx = 1;
#         eltidx = 1;
#
#         %
#         % Use ekgc to retrieve the string from
#         % row/column position.
#         %
#         [ cdata, isnull, found ] = ekgc( selidx, ...
#                                                 rowno,  ...
#                                                 eltidx, ...
#                                                 MAXSTR );
#
#         %
#         % Output the value, if non-null data exist at the
#         % requested position.
#         %
#         if  ~isnull
#            fprintf( 'Character data: %s\n', cdata );
#         end
#
#      end
#
#      %
#      % Clear the kernel pool and database. Note, you don't normally
#      % unload an EK after a query, rather at the end of a program.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Character data: SEG_2_C_COL_1_ROW_1
#      Character data: SEG_2_C_COL_1_ROW_2
#      Character data: SEG_2_C_COL_1_ROW_3
#      Character data: SEG_2_C_COL_1_ROW_4
#      Character data: SEG_2_C_COL_1_ROW_5
#      Character data: SEG_2_C_COL_1_ROW_6
#      Character data: SEG_2_C_COL_1_ROW_7
#      Character data: SEG_2_C_COL_1_ROW_8
#      Character data: SEG_2_C_COL_1_ROW_9
#      Character data: SEG_2_C_COL_1_ROW_10
#      Character data: SEG_2_C_COL_1_ROW_11
#      Character data: SEG_2_C_COL_1_ROW_12
#      Character data: SEG_2_C_COL_1_ROW_13
#      Character data: SEG_2_C_COL_1_ROW_14
#      Character data: SEG_2_C_COL_1_ROW_15
#      Character data: SEG_2_C_COL_1_ROW_16
#      Character data: SEG_2_C_COL_1_ROW_17
#      Character data: SEG_2_C_COL_1_ROW_18
#      Character data: SEG_2_C_COL_1_ROW_19
#      Character data: SEG_2_C_COL_1_ROW_20
#
#-Version
#
#   -Mice Version 1.2.0, 10-MAY-2011, EDW (JPL)
#
#      "logical" call replaced with "zzmice_logical."
#
#   -Mice Version 1.0.0, 10-APR-2010, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    ######   #####   ####     ##    #
#    #          #    #    #   #  #   #
#    #####      #    #       #    #  #
#    #          #    #       ######  #
#    #          #    #    #  #    #  #
#    ######     #     ####   #    #  ######
#
#   Convert ephemeris time to a formal calendar date
#
################################################################################
#-Abstract
#
#   etcal converts an ephemeris epoch measured in seconds past
#   the epoch of J2000 to a calendar string format using a
#   formal calendar free of leapseconds.
#
#-I/O
#
#   Given:
#
#      et   the double precision scalar or 1xN array of ephemeris
#           time expressed as ephemeris seconds past J2000
#
#   the call:
#
#      string = etcal(et)
#
#   returns:
#
#      string   the scalar string or NXM character array representing
#               the input ephemeris epoch 'et'. This string is based upon
#               extending the Gregorian Calendar backward and forward
#               indefinitely keeping the same rules for determining leap
#               years. Moreover, there is no accounting for leapseconds.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine etcal_c.
#
#   MICE.REQ
#
    function # etcal
#       (string::AbstractString) =   # Ptr{SpiceChar}
        etcal(
            et::Float64) # SpiceDouble

#       enforce input array sizes
#       allocate the output parameters
        string_array = Array{UInt8}(256)
        string_ptr = pointer( string_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:etcal_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceDouble,SpiceInt,Ptr{SpiceChar}),et,lenout,string)
        ccall((:etcal_c,libNasaSpice),Void,
            (Float64,Int64,Ptr{SpiceChar}),
            et,255,string_ptr)

#       unpack any structures and transpose back any returned arrays
        string = bytestring( string_ptr )
        return (string)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Load a leapseconds kernel.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Define a UTC time string.
#      %
#      TIMESTR = '2013 JUN 30 00:00:00.000';
#
#      %
#      % Convert the time string to ephemeris time.
#      %
#      et  = cspice_str2et( TIMESTR );
#
#      %
#      % Convert the ephemeris time to a time string, the conversion
#      % ignoring leapseconds. Note, this evaluation does not require
#      % loading a leapsecond kernel.
#      %
#      cal = etcal( et );
#
#      %
#      % Display the two time strings.
#      %
#      disp( ['Original times string: ' TIMESTR] )
#      disp( ['ETCAL time string    : ' cal    ] )
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Original times string: 2013 JUN 30 00:00:00.000
#      ETCAL time string    : 2013 JUN 30 00:01:05.184
#
#-Version
#
#   -Mice Version 1.0.1, 06-MAY-2009, EDW (JPL)
#
#      Added MICE.REQ reference to the Required Reading section.
#
#   -Mice Version 1.0.0, 07-MAR-2007, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#                    #####
#    ######   ##### #     #  #        ####    #####
#    #          #         #  #       #          #
#    #####      #    #####   #        ####      #
#    #          #   #        #            #     #
#    #          #   #        #       #    #     #
#    ######     #   #######  ######   ####      #
#
#   Compute the local time for a point on a body.
#
################################################################################
#-Abstract
#
#   et2lst computes the local solar time at a given ephemeris epoch,
#   for an object on the surface of a body at a specified longitude.
#
#-I/O
#
#   Given:
#
#      et     the double precision scalar or 1xN array of ephemeris
#             time expressed as ephemeris seconds past J2000 at which
#             a local time is desired
#
#      body   an integer scalar SPICE ID-code of the body on which local
#             time is to be measured
#
#      lon    the scalar double precision longitude (either planetocentric
#             or planetographic) in radians of the site on the surface
#             of body for which local time should be computed
#
#      type   is the form of longitude supplied by the variable
#             lon.   Allowed values are "PLANETOCENTRIC" and
#             "PLANETOGRAPHIC".  Note the case of the letters
#             in type is insignificant.  Both "PLANETOCENTRIC"
#             and "planetocentric" are recognized.  Leading and
#             trailing blanks in type are not significant.
#
#   the call:
#
#      [ hr, min, sec, time, ampm] = et2lst( et, body, lon, type)
#
#   returns:
#
#      hr     a double precision scalar or double precision 1xN array describing
#             the integral number of the local "hour" of the site specified
#             at epoch 'et'
#
#             Note that an "hour" of local time does not have the same duration
#             as an hour measured by conventional clocks. It is simply a
#             representation of an angle.
#
#      mn     a double precision scalar or double precision 1xN array describing
#             the integral number of "minutes" past the hour of the local time
#             of the site at the epoch 'et'
#
#             Again note that a "local minute" is not the same as a minute you
#             would measure with conventional clocks
#
#      sc     a double precision scalar or double precision 1xN array describing
#             the integral number of "seconds" past the minute of the local time
#             of the site at the epoch `et'
#
#             Again note that a "local second" is not the same as a second
#             you would measure with conventional clocks.
#
#      time   the scalar string or NXM character array of output local time
#             on a "24 hour" local clock
#
#      ampm   the scalar string or NXM character array of output local time
#             on a "12 hour" local clock together with the traditional AM/PM
#             label to indicate whether the sun has crossed the local zenith
#             meridian.
#
#             All output arguments return with the same measure of
#             vectorization, N, as 'et'.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine et2lst_c.
#
#   MICE.REQ
#
    function # et2lst
#       (hr::Int64,  # Ptr{SpiceInt}
#        mn::Int64,  # Ptr{SpiceInt}
#        sc::Int64,  # Ptr{SpiceInt}
#        time::AbstractString,  # Ptr{SpiceChar}
#        ampm::AbstractString) =   # Ptr{SpiceChar}
        et2lst(
            et::Float64, # SpiceDouble
            body::Int64, # SpiceInt
            lon::Float64, # SpiceDouble
            _type::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        hr = Array{Int64}(1);  # Ptr{SpiceInt}
        hr_ptr = pointer(hr)
        mn = Array{Int64}(1);  # Ptr{SpiceInt}
        mn_ptr = pointer(mn)
        sc = Array{Int64}(1);  # Ptr{SpiceInt}
        sc_ptr = pointer(sc)
        time_array = Array{UInt8}(256)
        time_ptr = pointer( time_array )
        ampm_array = Array{UInt8}(256)
        ampm_ptr = pointer( ampm_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:et2lst_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(SpiceDouble,SpiceInt,SpiceDouble,Ptr{ConstSpiceChar},SpiceInt,SpiceInt,Ptr{SpiceInt},Ptr{SpiceInt},Ptr{SpiceInt},Ptr{SpiceChar},Ptr{SpiceChar}),
#et,body,lon,_type,timlen,ampmlen,hr,mn,sc,time,ampm)
        ccall((:et2lst_c,libNasaSpice),Void,
            (Float64,Int64,Float64,Ptr{UInt8},Int64,Int64,Ptr{Int64},Ptr{Int64},Ptr{Int64},Ptr{SpiceChar},Ptr{SpiceChar}),
            et,body,lon,_type,255,255,hr_ptr,mn_ptr,sc_ptr,time_ptr,ampm_ptr)

#       unpack any structures and transpose back any returned arrays
        time = bytestring( time_ptr )
        ampm = bytestring( ampm_ptr )
        return (hr[1], mn[1], sc[1], time, ampm)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Load a leapseconds kernel.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Define two UTC time strings to 'utc'
#      %
#      utc                        = strvcat( '2002 SEP 02 00:00:00', ...
#                                            '2002 SEP 30 00:00:00' );
#
#      %
#      % Convert 'utc' the ephemeris time, 'et'
#      %
#      et                         = cspice_str2et(utc);
#
#      %
#      % Define a planetographic longitude in degrees, convert the
#      % value to radians
#      %
#      dlon                       =  326.17;
#      rlon                       =  dlon * cspice_rpd;
#
#      %
#      % Convert inputs to Local Solar Time.
#      %
#      [hr, min, sec, time, ampm] = et2lst( et,   ...
#                                                  499,  ...
#                                                  rlon, ...
#                                                  'PLANETOGRAPHIC');
#
#      fprintf( ['The local time at Mars %6.2f degrees E ' ...
#               'planetographic longitude:\n'],            ...
#               dlon )
#      fprintf( '   at UTC %s, LST = %s\n', utc(1,:), ampm(1,:) )
#      fprintf( '   at UTC %s, LST = %s\n', utc(2,:), ampm(2,:) )
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      The local time at Mars 326.17 degrees E planetographic longitude:
#         at UTC 2002 SEP 02 00:00:00, LST = 03:25:35 A.M.
#         at UTC 2002 SEP 30 00:00:00, LST = 09:33:00 A.M.
#
#-Version
#
#   -Mice Version 1.0.1, 06-MAY-2009, EDW (JPL)
#
#      Added MICE.REQ reference to the Required Reading section.
#
#   -Mice Version 1.0.0, 07-MAR-2007, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#                    #####
#    ######   ##### #     #  #    #   #####   ####
#    #          #         #  #    #     #    #    #
#    #####      #    #####   #    #     #    #
#    #          #   #        #    #     #    #
#    #          #   #        #    #     #    #    #
#    ######     #   #######   ####      #     ####
#
#   ephemeris time to utc
#
################################################################################
#-Abstract
#
#   et2utc converts an input time from ephemeris seconds
#   past J2000 to Calendar, Day-of-Year, or Julian Date format, UTC.
#
#-I/O
#
#   Given:
#
#      et       the double precision scalar or 1xN array of ephemeris
#               time expressed as ephemeris seconds past J2000
#
#      format   the scalar string format flag describing the output time
#               string, it may be any of the following:
#
#                  'C'      Calendar format, UTC
#
#                  'D'      Day-of-Year format, UTC
#
#                  'J'      Julian Date format, UTC
#
#                  'ISOC'   ISO Calendar format, UTC
#
#                  'ISOD'   ISO Day-of-Year format, UTC
#
#      prec     the scalar integer number of decimal places of precision to
#               which fractional seconds (for Calendar and Day-of-Year
#               formats) or days (for Julian Date format) are to be
#               computed
#
#   the call:
#
#      utcstr = et2utc( et, format, prec )
#
#   returns:
#
#      utcstr    the scalar string or NXM character array of output time
#                strings equivalent to the input epoch 'et', in the specified
#                'format'
#
#                'utcstr' returns with the same vectorization measure (N)
#                as 'et'.
#
#-Particulars
#
#   Use of this routine requires a loaded leapseconds kernel.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine et2utc_c.
#
#   MICE.REQ
#   TIME.REQ
#
    function # et2utc
#       (utcstr::AbstractString) =   # Ptr{SpiceChar}
        et2utc(
            et::Float64, # SpiceDouble
            format::AbstractString, # Ptr{ConstSpiceChar}
            prec::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        utcstr_array = Array{UInt8}(256)
        utcstr_ptr = pointer( utcstr_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:et2utc_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(SpiceDouble,Ptr{ConstSpiceChar},SpiceInt,SpiceInt,Ptr{SpiceChar}),et,format,prec,lenout,utcstr)
        ccall((:et2utc_c,libNasaSpice),Void,
            (Float64,Ptr{UInt8},Int64,Int64,Ptr{SpiceChar}),
            et,format,prec,255,utcstr_ptr)

#       unpack any structures and transpose back any returned arrays
        utcstr = bytestring( utcstr_ptr )
        return (utcstr)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Define an arbitrary ephemeris time.
#      %
#      et     = -527644192.5403653;
#      format = 'J';
#      prec   = 6;
#      SIZE   = 5;
#
#      %
#      % Load a leapseconds kernel.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Convert the ephemeris time to Julian Date
#      % 'format'. Define precision to 6 decimal
#      % places.
#      %
#      utcstr = et2utc( et, format, prec );
#      disp( 'Scalar:' )
#
#      txt = sprintf( 'ET              : %12.4f', et );
#      disp(txt)
#
#      txt = sprintf( 'Converted output: %s', utcstr );
#      disp( txt )
#
#      %
#      % Create an array of ephemeris times beginning
#      % at -527644192.5403653 with graduations of 10000.0
#      % ephemeris seconds.
#      %
#      et     = [0:(SIZE-1)]*10000. -527644192.5403653;
#      format = 'C';
#
#      %
#      % Convert the array of ephemeris times 'et' to an
#      % array of UTC strings, 'utcstr', in calendar
#      % 'format'.
#      %
#      utcstr= et2utc( et, format, prec );
#
#      disp( ' ' )
#      disp( 'Vector:' )
#
#      for n=1:SIZE
#
#         txt = sprintf( 'ET              : %12.4f', et(n) );
#         disp( txt )
#
#         txt = sprintf( 'Converted output: %s', utcstr(n,:) );
#         disp( txt )
#
#         disp(' ' )
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Scalar:
#      ET              : -527644192.5404
#      Converted output: JD 2445438.006415
#
#      Vector:
#      ET              : -527644192.5404
#      Converted output: 1983 APR 13 12:09:14.274000
#
#      ET              : -527634192.5404
#      Converted output: 1983 APR 13 14:55:54.274001
#
#      ET              : -527624192.5404
#      Converted output: 1983 APR 13 17:42:34.274001
#
#      ET              : -527614192.5404
#      Converted output: 1983 APR 13 20:29:14.274002
#
#      ET              : -527604192.5404
#      Converted output: 1983 APR 13 23:15:54.274002
#
#-Version
#
#   -Mice Version 1.0.0, 22-NOV-2005, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    ######  #####   #    #  #    #    ##    #    #
#    #       #    #  ##  ##  ##   #   #  #   ##  ##
#    #####   #    #  # ## #  # #  #  #    #  # ## #
#    #       #####   #    #  #  # #  ######  #    #
#    #       #   #   #    #  #   ##  #    #  #    #
#    #       #    #  #    #  #    #  #    #  #    #
#
#   frame ID code to frame name translation
#
################################################################################
#-Abstract
#
#   frmnam retrieves the name of a reference frame associated with a
#   SPICE frame ID code.
#
#-I/O
#
#   Given:
#
#     frcode   value defining a SPICE reference frame ID code.
#
#              [1,n] = size(frcode); int32 = class(frcode)
#
#   the call:
#
#      frmname = frmnam( frcode )
#
#   returns:
#
#      frmnam   the frame name corresponding to the 'frcode' code.
#
#               [n,m] = size(frmnam); char = class(frmnam)
#
#               If frcode is not recognized as the name of a known reference
#               frame, 'frname' will be returned as an empty string.
#
#-Particulars
#
#   This routine retrieves the name of a reference frame associated
#   with a SPICE frame ID code.
#
#   The ID codes stored locally are scanned for a match with frcode.
#   If a match is found, the name stored locally will be returned
#   as the name for the frame.
#
#   If frcode is not a member of the list of internally stored
#   ID codes, the kernel pool will be examined to see if the
#   variable
#
#      FRAME_idcode_NAME
#
#   is present (where idcode is the decimal character equivalent
#   of frcode).  If the variable is located and it has both
#   character type and dimension 1, the string value of the
#   kernel pool variable is returned as the name of the reference
#   frame.
#
#   Note that because the local information is always examined
#   first and searches of the kernel pool are performed only
#   after exhausting local information, it is not possible to
#   override the local name for any reference frame that is
#   known by this routine.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine frmnam_c.
#
#   MICE.REQ
#   FRAMES.REQ
#
    function # frmnam
#       (frname::AbstractString) =   # Ptr{SpiceChar}
        frmnam(
            frcode::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        frname_array = Array{UInt8}(256)
        frname_ptr = pointer( frname_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:frmnam_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceInt,Ptr{SpiceChar}),frcode,lenout,frname)
        ccall((:frmnam_c,libNasaSpice),Void,
            (Int64,Int64,Ptr{SpiceChar}),
            frcode,255,frname_ptr)

#       unpack any structures and transpose back any returned arrays
        frname = bytestring( frname_ptr )
        return (frname)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Retrieve frame information for a scalar code.
#      %
#      disp('Scalar' )
#      code = 13000;
#
#      %
#      % Output the frame name corresponding to 'code'.
#      %
#      frmname = frmnam( code )
#
#
#      %
#      % Retrieve frame information for a vector of codes.
#      %
#      disp('Vector' )
#      codes = [1:5];
#
#      %
#      % Output the frame names corresponding to the 'codes'.
#      %
#      frmname = frmnam( codes )
#
#   MATLAB outputs:
#
#      Scalar
#
#      frmname =
#
#      ITRF93
#
#      Vector
#
#      frmname =
#
#      J2000
#      B1950
#      FK4
#      DE-118
#      DE-96
#
#-Version
#
#   -Mice Version 1.0.0, 12-MAR-2012, EDW (JPL), SCK (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####   ######   #####  ######   ####   #    #
#    #    #  #          #    #       #    #  #    #
#    #       #####      #    #####   #    #  #    #
#    #  ###  #          #    #       #    #  #    #
#    #    #  #          #    #       #    #   #  #
#     ####   ######     #    #        ####     ##
#
#   return instrument's FOV parameters
#
################################################################################
#-Abstract
#
#   getfov returns the field-of-view parameters for a user
#   specified instrument.
#
#-I/O
#
#   Given:
#
#      instid   NAIF ID for the instrument of interest.
#
#               [1,1] = size(instid); int32 = class(instid)
#
#      room     the max number of double precision 'bounds' vectors to return.
#
#               [1,1] = size(room); int32 = class(room)
#
#   the call:
#
#      [shape, frame, bsight, bounds] = getfov( instid, room)
#
#   returns:
#
#      shape    the FOV shape for instrument 'instid'. Possible values:
#
#               [1,m] = size(shape); char = class(shape)
#
#                    "POLYGON"
#                    "RECTANGLE"
#                    "CIRCLE"
#                    "ELLIPSE"
#
#      frame    the name of the frame in which the FOV is defined.
#
#               [1,m] = size(frame); char = class(frame)
#
#      bsight   the vector pointing in the direction of the FOV center
#               (boresight).
#
#               [3,1] = size(bsight); double = class(bsight)
#
#      bounds   set of vectors pointing to the "corners" of the instrument FOV,
#               i.e. 'bounds' returns as a N columns of 3-vectors.
#
#               [3,n] = size(bounds); double = class(bounds)
#
#               Note: do not consider 'bounds' as a matrix in the
#               conventional sense. Its 3XN form serves only as
#               a container for the bounds vectors.
#
#-Particulars
#
#   This routine provides a common interface to retrieving the geometric
#   characteristics of an instrument field of view for a wide variety of
#   remote sensing instruments across many different space missions.
#
#   Given the NAIF instrument ID, (and having "loaded" the
#   instrument field of view description via the routine cspice_furnsh)
#   this routine returns the bore-sight of the instrument, the
#   "shape" of the field of view, a collection of vectors
#   that point along the edges of the field of view, and the
#   name of the reference frame in which these vectors are defined.
#
#   Currently this routine supports two classes of specifications
#   for FOV definitions: "corners" and "angles".
#
#   The "corners" specification requires the following keywords
#   defining the shape, boresight, boundary vectors, and reference
#   frame of the FOV be provided in one of the text kernel files
#   (normally an IK file) loaded into the kernel pool (in the
#   keywords below <INSTID> is replaced with the instrument ID as
#   passed into the module):
#
#      INS<INSTID>_FOV_CLASS_SPEC         must be set to 'CORNERS' or
#                                         omitted to indicate the
#                                         "corners"-class
#                                         specification.
#
#
#      INS<INSTID>_FOV_SHAPE              must be set to one of these
#                                         values:
#
#                                            'CIRCLE'
#                                            'ELLIPSE'
#                                            'RECTANGLE'
#                                            'POLYGON'
#
#      INS<INSTID>_FOV_FRAME              must contain the name of
#                                         the frame in which the
#                                         boresight and boundary
#                                         corner vectors are defined.
#
#      INS<INSTID>_BORESIGHT              must be set to a 3D vector
#                                         defining the boresight in
#                                         the FOV frame specified in
#                                         the FOV_FRAME keyword.
#
#      INS<INSTID>_FOV_BOUNDARY   or
#      INS<INSTID>_FOV_BOUNDARY_CORNERS   must be set to one (for
#                                         FOV_SHAPE = 'CIRCLE'), two
#                                         (for FOV_SHAPE =
#                                         'ELLIPSE'), three (for
#                                         FOV_SHAPE = 'RECTANGLE'),
#                                         or three or more (for
#                                         'POLYGON') 3D vectors
#                                         defining the corners of the
#                                         FOV in the FOV frame
#                                         specified in the FOV_FRAME
#                                         keyword.
#
#   The "angles" specification requires the following keywords
#   defining the shape, boresight, reference vector, reference and
#   cross angular extents of the FOV be provided in one of the text
#   kernel files (normally an IK file) loaded into the kernel
#   pool (in the keywords below <INSTID> is replaced with the
#   instrument ID as passed into the module):
#
#      INS<INSTID>_FOV_CLASS_SPEC         must be set to  'ANGLES' to
#                                         indicate the "angles"-class
#                                         specification.
#
#      INS<INSTID>_FOV_SHAPE              must be set to one of these
#                                         values:
#
#                                            'CIRCLE'
#                                            'ELLIPSE'
#                                            'RECTANGLE'
#
#      INS<INSTID>_FOV_FRAME              must contain the name of
#                                         the frame in which the
#                                         boresight and the computed
#                                         boundary corner vectors are
#                                         defined.
#
#      INS<INSTID>_BORESIGHT              must be set to a 3D vector
#                                         defining the boresight in
#                                         the FOV frame specified in
#                                         the FOV_FRAME keyword.
#
#      INS<INSTID>_FOV_REF_VECTOR         must be set to a 3D vector
#                                         that together with the
#                                         boresight vector defines
#                                         the plane in which the
#                                         first angular extent of the
#                                         FOV specified in the
#                                         FOV_REF_ANGLE keyword is
#                                         measured.
#
#      INS<INSTID>_FOV_REF_ANGLE          must be set to the angle
#                                         that is 1/2 of the total
#                                         FOV angular extent in the
#                                         plane defined by the
#                                         boresight and the vector
#                                         specified in the
#                                         FOV_REF_VECTOR keyword.
#
#      INS<INSTID>_FOV_CROSS_ANGLE        must be set to the angle
#                                         that is 1/2 of the total
#                                         FOV angular extent in the
#                                         plane containing the
#                                         boresight and perpendicular
#                                         to the plane defined by the
#                                         boresight and the vector
#                                         specified in the
#                                         FOV_REF_VECTOR keyword.
#                                         This keyword is not
#                                         required for FOV_SHAPE =
#                                         'CIRCLE'.
#
#      INS<INSTID>_FOV_ANGLE_UNITS        must specify units for the
#                                         angles given in the
#                                         FOV_REF_ANGLE and
#                                         FOV_CROSS_ANGLE keywords.
#                                         Any angular units
#                                         recognized by cspice_convrt
#                                         are acceptable.
#
#   This routine is intended to be an intermediate level routine.
#   It is expected that users of this routine will be familiar
#   with the SPICE frames subsystem and will be comfortable writing
#   software to further manipulate the vectors retrieved by this
#   routine.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine getfov_c.
#
#   MICE.REQ
#
    function # getfov
#       (shape::AbstractString,  # Ptr{SpiceChar}
#        frame::AbstractString,  # Ptr{SpiceChar}
#        bsight::Array{Float64}(3),  # Array_3_SpiceDouble
#        bounds::Array{Float64}(3)) =   # Ptr{Array_3_SpiceDouble}
        getfov(
            instid::Int64, # SpiceInt
            room::Int64) # SpiceInt

#       enforce input array sizes
#       allocate the output parameters
        shape_array = Array{UInt8}(256)
        shape_ptr = pointer( shape_array )
        frame_array = Array{UInt8}(256)
        frame_ptr = pointer( frame_array )
        bsight = Array{Float64}(3);  # Array_3_SpiceDouble
        bsight_ptr = pointer(bsight)
        bounds = Array{Float64}(3);  # Ptr{Array_3_SpiceDouble}
        bounds_ptr = pointer(bounds)

#       make transposed copies of all input arrays and their pointers

#       ccall((:getfov_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(SpiceInt,SpiceInt,SpiceInt,SpiceInt,Ptr{SpiceChar},Ptr{SpiceChar},Array_3_SpiceDouble,Ptr{SpiceInt},Ptr{Array_3_SpiceDouble}),
# instid,room,shapelen,framelen,shape,frame,bsight,n,bounds)
        ccall((:getfov_c,libNasaSpice),Void,
            (Int64,Int64,Int64,Int64,Ptr{SpiceChar},Ptr{SpiceChar},Ptr{Float64},Ptr{Float64}),
            instid,room,255,255,shape_ptr,frame_ptr,bsight_ptr,bounds_ptr)

#       unpack any structures and transpose back any returned arrays
        shape = bytestring( shape_ptr )
        frame = bytestring( frame_ptr )
        return (shape, frame, bsight', bounds')
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#   The example program in this section loads the IK file
#   'example.ti' with the following contents defining four FOVs of
#   various shapes and sizes:
#
#      KPL/IK
#
#      The keywords below define a circular, 10-degree wide FOV with
#      the boresight along the +Z axis of the 'SC999_INST001' frame
#      for an instrument with ID -999001 using the "angles"-class
#      specification.
#
#      \begindata
#         INS-999001_FOV_CLASS_SPEC       = 'ANGLES'
#         INS-999001_FOV_SHAPE            = 'CIRCLE'
#         INS-999001_FOV_FRAME            = 'SC999_INST001'
#         INS-999001_BORESIGHT            = ( 0.0, 0.0, 1.0 )
#         INS-999001_FOV_REF_VECTOR       = ( 1.0, 0.0, 0.0 )
#         INS-999001_FOV_REF_ANGLE        = ( 5.0 )
#         INS-999001_FOV_ANGLE_UNITS      = ( 'DEGREES' )
#      \begintext
#
#      The keywords below define an elliptical FOV with 2- and
#      4-degree angular extents in the XZ and XY planes and the
#      boresight along the +X axis of the 'SC999_INST002' frame for
#      an instrument with ID -999002 using the "corners"-class
#      specification.
#
#      \begindata
#         INS-999002_FOV_SHAPE            = 'ELLIPSE'
#         INS-999002_FOV_FRAME            = 'SC999_INST002'
#         INS-999002_BORESIGHT            = ( 1.0, 0.0, 0.0 )
#         INS-999002_FOV_BOUNDARY_CORNERS = ( 1.0, 0.0, 0.01745506,
#                                             1.0, 0.03492077, 0.0 )
#      \begintext
#
#      The keywords below define a rectangular FOV with 1.2- and
#      0.2-degree angular extents in the ZX and ZY planes and the
#      boresight along the +Z axis of the 'SC999_INST003' frame for
#      an instrument with ID -999003 using the "angles"-class
#      specification.
#
#      \begindata
#         INS-999003_FOV_CLASS_SPEC       = 'ANGLES'
#         INS-999003_FOV_SHAPE            = 'RECTANGLE'
#         INS-999003_FOV_FRAME            = 'SC999_INST003'
#         INS-999003_BORESIGHT            = ( 0.0, 0.0, 1.0 )
#         INS-999003_FOV_REF_VECTOR       = ( 1.0, 0.0, 0.0 )
#         INS-999003_FOV_REF_ANGLE        = ( 0.6 )
#         INS-999003_FOV_CROSS_ANGLE      = ( 0.1 )
#         INS-999003_FOV_ANGLE_UNITS      = ( 'DEGREES' )
#      \begintext
#
#      The keywords below define a triangular FOV with the boresight
#      along the +Y axis of the 'SC999_INST004' frame for an
#      instrument with ID -999004 using the "corners"-class
#      specification.
#
#      \begindata
#         INS-999004_FOV_SHAPE            = 'POLYGON'
#         INS-999004_FOV_FRAME            = 'SC999_INST004'
#         INS-999004_BORESIGHT            = (  0.0,  1.0,  0.0 )
#         INS-999004_FOV_BOUNDARY_CORNERS = (  0.0,  0.8,  0.5,
#                                              0.4,  0.8, -0.2,
#                                             -0.4,  0.8, -0.2 )
#      \begintext
#
#
#   The program shown below loads the IK, fetches parameters for each
#   of the four FOVs and prints these parameters to the screen.
#
#      function getfov_t()
#
#      %
#      % Set maximum number of boundary vectors, number of
#      % instruments and instrument IDs.
#      %
#      MAXBND = 4;
#      NUMINS = 4;
#      insids = [ -999001, -999002, -999003, -999004 ];
#
#      %
#      % Load the IK file.
#      %
#      cspice_furnsh ( 'example.ti' );
#
#      %
#      % For each instrument ...
#      %
#      fprintf ( '--------------------------------------\n' );
#      for i = 1:NUMINS
#
#         %
#         % ... fetch FOV parameters and ...
#         %
#         [shape, frame, bsight, bounds] = ...
#                  getfov( insids(i), MAXBND );
#
#         %
#         % ... print them to the screen.
#         %
#         fprintf ( 'Instrument ID: %i\n', insids(i) );
#         fprintf ( '    FOV shape: %s\n', shape );
#         fprintf ( '    FOV frame: %s\n', frame );
#         fprintf ( 'FOV boresight: %f %f %f\n', ...
#                   bsight(1), bsight(2), bsight(3) );
#
#         fprintf ( '  FOV corners: \n' );
#         [m,n] = size(bounds);
#         for j= 1:n
#            fprintf ( '               %f %f %f\n', ...
#                      bounds(1,j), bounds(2,j), bounds(3,j) );
#         end
#
#         fprintf ( '--------------------------------------\n' );
#
#      end
#
#   The program produces the following output:
#
#      --------------------------------------
#      Instrument ID: -999001
#          FOV shape: CIRCLE
#          FOV frame: SC999_INST001
#      FOV boresight: 0.000000 0.000000 1.000000
#        FOV corners:
#                     0.087156 0.000000 0.996195
#      --------------------------------------
#      Instrument ID: -999002
#          FOV shape: ELLIPSE
#          FOV frame: SC999_INST002
#      FOV boresight: 1.000000 0.000000 0.000000
#        FOV corners:
#                     1.000000 0.000000 0.017455
#                     1.000000 0.034921 0.000000
#      --------------------------------------
#      Instrument ID: -999003
#          FOV shape: RECTANGLE
#          FOV frame: SC999_INST003
#      FOV boresight: 0.000000 0.000000 1.000000
#        FOV corners:
#                     0.010472 0.001745 0.999944
#                     -0.010472 0.001745 0.999944
#                     -0.010472 -0.001745 0.999944
#                     0.010472 -0.001745 0.999944
#      --------------------------------------
#      Instrument ID: -999004
#          FOV shape: POLYGON
#          FOV frame: SC999_INST004
#      FOV boresight: 0.000000 1.000000 0.000000
#        FOV corners:
#                     0.000000 0.800000 0.500000
#                     0.400000 0.800000 -0.200000
#                     -0.400000 0.800000 -0.200000
#      --------------------------------------
#
#-Version
#
#   -Mice Version 1.0.3, 12-MAR-2012, EDW (JPL), SCK (JPL)
#
#       I/O descriptions edits to conform to Mice documentation format.
#
#   -Mice Version 1.0.2, 24-APR-2010, EDW (JPL)
#
#      Minor edit to code comments eliminating typo.
#
#   -Mice Version 1.0.1, 05-FEB-2009, BVS (JPL)
#
#      Header update: added information about required IK keywords;
#      replaced old example with a new one more focused on getfov_c and
#      IK keywords.
#
#   -Mice Version 1.0.0, 07-DEC-2005, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    #    #  #####     ##     #####    ##
#    #   #   #    #   #  #      #     #  #
#    ####    #    #  #    #     #    #    #
#    #  #    #    #  ######     #    ######
#    #   #   #    #  #    #     #    #    #
#    #    #  #####   #    #     #    #    #
#
#   Retrieve information on loaded SPICE kernels
#
################################################################################
#-Abstract
#
#   kdata returns data for the nth kernel among a list of specified
#   kernel types.
#
#-I/O
#
#   Given:
#
#      which   index of the kernel to fetch (matching the type specified by
#              kind) from the list of kernels loaded using cspice_furnsh but
#              not unloaded using cspice_unload or cleared by cspice_klear.
#
#              [1,1] = size(which); int32 = class(which)
#
#              The range of 'which' is 1 to 'count', where 'count' is
#              the number of kernels loaded via cspice_furnsh. Retrieve
#              this value from a cspice_ktotal call.  See the
#              Examples section for an illustrative code fragment.
#
#     kind     list of types of kernels to consider when fetching kernels from
#              the list of loaded kernels. 'kind' should consist of a list of
#              words of kernels to examine. Recognized types are
#
#              [1,m] = size(kind); char = class(kind)
#
#                 SPK
#                 CK
#                 PCK
#                 EK
#                 TEXT
#                 META
#                 ALL
#
#              'kind' lacks case sensitivity. The kdata algorithm
#              ignores words in 'kind' if not one of those listed above.
#
#              See the routine cspice_ktotal for example use 'kind'.
#
#   the call:
#
#      [file, filtyp, source, handle, found] = kdata(which, kind)
#
#   returns:
#
#      file     name of the file having index 'which' in the sequence of files
#               of type 'kind' currently loaded via cspice_furnsh. 'file'
#               returns empty if no loaded kernels match the specification of
#               'which' and 'kind'.
#
#               [1,m] = size(file); char = class(file)
#
#      filtyp   name of the type of kernel specified by 'file'. 'filtyp' will
#               be empty if no loaded kernels match the specification of
#               'which' and 'kind'.
#
#               [1,m] = size(filtyp); char = class(filtyp)
#
#      source   name of the source file used to specify file as one to load. If
#               file was loaded directly via a call to cspice_furnsh, 'source'
#               will be empty. If there is no file matching the specification
#               of which and kind, 'source' will be empty.
#
#               [1,m] = size(source); char = class(source)
#
#      handle   handle attached to file if it is a binary kernel.  If file is a
#               text kernel or meta-text kernel handle will be zero.  If there
#               is no file matching the specification of 'which' and 'kind',
#               'handle' will be set to zero.
#
#               [1,1] = size(handle); int32 = class(handle)
#
#      found    flag indicating if a file matching the specification of 'which'
#               and 'kind' exists. If there no such file exists, 'found'
#               returns false (if 'found' returns as false, all return strings
#               are empty, not null).
#
#               [1,1] = size(found); logical = class(found)
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine kdata_c.
#
#   MICE.REQ
#
    function # kdata
#       (file::AbstractString,  # Ptr{SpiceChar}
#        filtyp::AbstractString,  # Ptr{SpiceChar}
#        source::AbstractString,  # Ptr{SpiceChar}
#        handle::Int64,  # Ptr{SpiceInt}
#        found::Int32) =   # Ptr{SpiceBoolean}
        kdata(
            which::Int64, # SpiceInt
            kind::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        file_array = Array{UInt8}(256)
        file_ptr = pointer( file_array )
        filtyp_array = Array{UInt8}(256)
        filtyp_ptr = pointer( filtyp_array )
        source_array = Array{UInt8}(256)
        source_ptr = pointer( source_array )
        handle = Array{Int64}(1);  # Ptr{SpiceInt}
        handle_ptr = pointer(handle)
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:kdata_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(SpiceInt,Ptr{ConstSpiceChar},SpiceInt,SpiceInt,SpiceInt,Ptr{SpiceChar},Ptr{SpiceChar},Ptr{SpiceChar},Ptr{SpiceInt},Ptr{SpiceBoolean}),
# which,kind,fillen,typlen,srclen,file,filtyp,source,handle,found)
        ccall((:kdata_c,libNasaSpice),Void,
            (Int64,Ptr{UInt8},Int64,Int64,Int64,Ptr{SpiceChar},Ptr{SpiceChar},Ptr{SpiceChar},Ptr{Int64},Ptr{Int32}),
            which,kind,255,25,255,file_ptr,filtyp_ptr,source_ptr,handle_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        file = bytestring( file_ptr )
        filtyp = bytestring( filtyp_ptr )
        source = bytestring( source_ptr )
        return (file, filtyp, source, handle[1], convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      Use the meta-kernel shown below to load the required SPICE
#      kernels.
#
#         KPL/MK
#
#         File name: standard.tm
#
#         This meta-kernel is intended to support operation of SPICE
#         example programs. The kernels shown here should not be
#         assumed to contain adequate or correct versions of data
#         required by SPICE-based user applications.
#
#         In order for an application to use this meta-kernel, the
#         kernels referenced here must be present in the user's
#         current working directory.
#
#         The names and contents of the kernels referenced
#         by this meta-kernel are as follows:
#
#            File name                     Contents
#            ---------                     --------
#            de421.bsp                     Planetary ephemeris
#            pck00009.tpc                  Planet orientation and
#                                          radii
#            naif0009.tls                  Leapseconds
#
#         \begindata
#
#            KERNELS_TO_LOAD = ( 'de421.bsp',
#                                'pck00009.tpc',
#                                'naif0009.tls'  )
#
#         \begintext
#
#   Example:
#
#      %
#      % Load several kernel files.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Count the number of loaded kernel files.
#      %
#      count = cspice_ktotal( 'ALL' );
#
#      %
#      % Loop over the count, outputting file information as we loop.
#      % The loop tells us all files loaded via cspice_furnsh, their
#      % type, and how they were loaded.
#      %
#      for i = 1:count+1
#
#         [ file, type, source, handle, found ] = ...
#                                          kdata( i, 'ALL');
#
#         if ( found )
#            fprintf( 'Index : %d\n', i     );
#            fprintf( 'File  : %s\n', file  );
#            fprintf( 'Type  : %s\n', type  );
#            fprintf( 'Source: %s\n\n', source);
#
#         else
#
#            fprintf( 'No kernel found with index: %d\n', i );
#
#         end
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in Mice due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Index : 1
#      File  : standard.tm
#      Type  : META
#      Source:
#
#      Index : 2
#      File  : de421.bsp
#      Type  : SPK
#      Source: standard.tm
#
#      Index : 3
#      File  : pck00009.tpc
#      Type  : TEXT
#      Source: standard.tm
#
#      Index : 4
#      File  : naif0009.tls
#      Type  : TEXT
#      Source: standard.tm
#
#      No kernel found with index: 5
#
#-Version
#
#   -Mice Version 1.2.0, 12-MAR-2012, EDW (JPL), SCK (JPL)
#
#      "logical" call replaced with "zzmice_logical."
#
#      I/O descriptions edits to parallel to Icy version.
#
#      Edited I/O section to conform to NAIF standard for Mice documentation.
#
#      Edits to Example section, proper description of "standard.tm"
#      meta kernel.
#
#   -Mice Version 1.0.1, 06-MAY-2009, EDW (JPL)
#
#      Added MICE.REQ reference to the Required Reading section.
#
#   -Mice Version 1.0.0, 30-MAR-2007, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#    #    #     #    #    #  ######   ####
#    #   #      #    ##   #  #       #    #
#    ####       #    # #  #  #####   #    #
#    #  #       #    #  # #  #       #    #
#    #   #      #    #   ##  #       #    #
#    #    #     #    #    #  #        ####
#
#   Fetch information about a loaded SPICE kernel
#
################################################################################
#-Abstract
#
#   kinfo returns information about a loaded kernel
#   specified by name.
#
#-I/O
#
#   Given:
#
#      file   the scalar string name of a kernel file for which descriptive
#             information is desired.
#
#   the call:
#
#      [ filtyp, source, handle, found] = kinfo( file)
#
#   returns:
#
#      filtyp   the scalar string type name of the kernel specified by 'file'.
#               'filtyp' will be empty if file is not on the list of kernels
#               loaded via cspice_furnsh.
#
#      source   the scalar string name of the source file used to
#               specify 'file' as one to load.  If 'file' was loaded
#               directly via a call to cspice_furnsh, 'source' will be empty.
#               If file is not on the list of kernels loaded via
#               cspice_furnsh, 'source' will be empty.
#
#      handle   the integer handle attached to 'file' if it is a binary
#               kernel.  If file is a text kernel or meta-text kernel
#               handle will be zero. If file is not on the list of
#               kernels loaded via cspice_furnsh, 'handle' has value zero.
#
#      found    returns true if the specified file exists.
#               If there is no such file, 'found' will be set to
#               false.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine kinfo_c.
#
#   MICE.REQ
#
    function # kinfo
#       (filtyp::AbstractString,  # Ptr{SpiceChar}
#        source::AbstractString,  # Ptr{SpiceChar}
#        handle::Int64,  # Ptr{SpiceInt}
#        found::Int32) =   # Ptr{SpiceBoolean}
        kinfo(
            file::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        filtyp_array = Array{UInt8}(256)
        filtyp_ptr = pointer( filtyp_array )
        source_array = Array{UInt8}(256)
        source_ptr = pointer( source_array )
        handle = Array{Int64}(1);  # Ptr{SpiceInt}
        handle_ptr = pointer(handle)
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:kinfo_c,"/home/don/.julia/v0.3/cspice.so"),Void,
#(Ptr{ConstSpiceChar},SpiceInt,SpiceInt,Ptr{SpiceChar},Ptr{SpiceChar},Ptr{SpiceInt},Ptr{SpiceBoolean}),
# file,typlen,srclen,filtyp,source,handle,found)
        ccall((:kinfo_c,libNasaSpice),Void,
            (Ptr{UInt8},Int64,Int64,Ptr{SpiceChar},Ptr{SpiceChar},Ptr{Int64},Ptr{Int32}),
            file,255,255,filtyp_ptr,source_ptr,handle_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        filtyp = bytestring( filtyp_ptr )
        source = bytestring( source_ptr )
        return (filtyp, source, handle[1], convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      Use the meta-kernel shown below to load the required SPICE
#      kernels.
#
#         KPL/MK
#
#         This meta-kernel is intended to support operation of SPICE
#         example programs. The kernels shown here should not be
#         assumed to contain adequate or correct versions of data
#         required by SPICE-based user applications.
#
#         In order for an application to use this meta-kernel, the
#         kernels referenced here must be present in the user's
#         current working directory.
#
#         The names and contents of the kernels referenced
#         by this meta-kernel are as follows:
#
#            File name                     Contents
#            ---------                     --------
#            de421.bsp                     Planetary ephemeris
#            pck00009.tpc                  Planet orientation and
#                                          radii
#            naif0009.tls                  Leapseconds
#
#
#         \begindata
#
#            KERNELS_TO_LOAD = ( '/kernels/gen/lsk/naif0009.tls'
#                                '/kernels/gen/spk/de421.bsp'
#                                '/kernels/gen/pck/pck00009.tpc'
#                      )
#
#         \begintext
#
#      %
#      % Load a meta kernel listing a path to an SPK file.
#      %
#      cspice_kclear
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Use kinfo to ensure the kernel system loaded
#      % the SPK file of interest.
#      %
#      file = '/kernels/gen/spk/de421.bsp';
#
#      [ filtyp, source, handle, found ] = kinfo( file );
#
#      %
#      % Take appropriate action depending on the returned
#      % state of found. If found has value false, then
#      % 'file' is not loaded.
#      %
#      if ( found )
#         disp( [ 'File type: ' filtyp ] )
#         disp( [ 'Source   : ' source ] )
#      else
#         disp( [ 'Kernel not loaded: ' file ] )
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in Mice due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      File type: SPK
#      Source   : standard.tm
#
#-Version
#
#   -Mice Version 1.2.0, 10-MAY-2011, EDW (JPL)
#
#      "logical" call replaced with "zzmice_logical."
#
#   -Mice Version 1.0.1, 06-MAY-2009, EDW (JPL)
#
#      Added MICE.REQ reference to the Required Reading section.
#
#   -Mice Version 1.0.0, 01-DEC-2006, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####    ####   #####   ######   ####   #####
#    #       #    #  #    #  #       #    #  #    #
#     ####   #       #    #  #####   #       #    #
#         #  #       #    #  #       #       #    #
#    #    #  #    #  #    #  #       #    #  #    #
#     ####    ####   #####   ######   ####   #####
#
#   decode spacecraft_clock
#
################################################################################
#-Abstract
#
#   scdecd converts a double precision encoding of spacecraft
#   clock time into a string representation.
#
#-I/O
#
#   Given:
#
#      sc       the integer scalar NAIF ID of the spacecraft clock
#               whose encoded clock value is represented by
#               'sclkdp'
#
#      sclkdp   the double precision scalar or double precision 1xN array
#               encoding of a clock time(s) in units of ticks since the
#               spacecraft clock start time
#
#   the call:
#
#      sclkch = scdecd( sc, sclkdp )
#
#   returns:
#
#      sclkch   the scalar string or NXM character array representation(s)
#               of the clock count 'sclkdp' for 'sc'
#
#               'sclkch' returns with the same vectorization measure (N)
#                as 'sclkdp'.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine scdecd_c.
#
#   MICE.REQ
#   SCLK.REQ
#
    function # scdecd
#       (sclkch::AbstractString) =   # Ptr{SpiceChar}
        scdecd(
            sc::Int64, # SpiceInt
            sclkdp::Float64) # SpiceDouble

#       enforce input array sizes
#       allocate the output parameters
        sclkch_array = Array{UInt8}(256)
        sclkch_ptr = pointer( sclkch_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:scdecd_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceDouble,SpiceInt,Ptr{SpiceChar}),sc,sclkdp,sclklen,sclkch)
        ccall((:scdecd_c,libNasaSpice),Void,
            (Int64,Float64,255,Ptr{SpiceChar}),
            sc,sclkdp,255,sclkch_ptr)

#       unpack any structures and transpose back any returned arrays
        sclkch = bytestring( sclkch_ptr )
        return (sclkch)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Assign values for the spacecraft ID (Voyager2),
#      % SCLK kernels, and an SCLK time string.
#      %
#      SC     = -32;
#      SCLK   = '/kernels/voyager2/sclk/vg200004.tsc';
#      sclkin =  '2/20538:39:768';
#
#      %
#      % Load the SCLK kernel.
#      %
#      cspice_furnsh( SCLK )
#
#      %
#      % Convert the Voyager SCLK strings to the
#      % corresponding double precision value.
#      %
#      timein = cspice_scencd( SC, sclkin );
#
#      %
#      % Convert the double precision value of
#      % the SCLK count back to string. The output
#      % string should nearly match the original
#      % with regards to roundoff and minus any
#      % embedded spaces.
#      %
#      sclkch = scdecd( SC, timein );
#
#      disp( 'Scalar:' )
#      txt = sprintf( 'Original: %s',  sclkin );
#      disp( txt )
#
#      txt = sprintf( 'Encoded : %20.8f',  timein );
#      disp( txt )
#
#      txt = sprintf( 'Decoded : %s', sclkch );
#      disp( txt )
#
#      %
#      % Convert a vector of SCLK strings. Define a set of strings.
#      %
#      sclkin =  strvcat( '2/20538:39:768' , ...
#                         '2/20543:21:768' , ...
#                         '2/20550:37'     , ...
#                         '2/20561:59'     , ...
#                         '5/04563:00:001'  );
#
#      %
#      % Convert the SCLK strings to the dp representation,
#      % then convert to the string form. As before, the
#      % output value should nearly match the original.
#      %
#      timein = cspice_scencd( SC, sclkin );
#      sclkch = scdecd( SC, timein );
#
#      disp(' ')
#
#      disp( 'Vector:' )
#      for i=1:5
#
#         txt = sprintf( 'Original: %s',  sclkin(i,:) );
#         disp( txt )
#
#         txt = sprintf( 'Encoded : %20.8f',  timein(i) );
#         disp( txt )
#
#         txt = sprintf( 'Decoded : %s', sclkch(i,:) );
#         disp( txt )
#         disp (' ')
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Scalar:
#      Original: 2/20538:39:768
#      Encoded :   985327950.00000000
#      Decoded : 2/20538:39:768
#
#      Vector:
#      Original: 2/20538:39:768
#      Encoded :   985327950.00000000
#      Decoded : 2/20538:39:768
#
#      Original: 2/20543:21:768
#      Encoded :   985553550.00000000
#      Decoded : 2/20543:21:768
#
#      Original: 2/20550:37
#      Encoded :   985901583.00000000
#      Decoded : 2/20550:37:001
#
#      Original: 2/20561:59
#      Encoded :   986447183.00000000
#      Decoded : 2/20561:59:001
#
#      Original: 5/04563:00:001
#      Encoded :  9136032015.00000000
#      Decoded : 5/04563:00:001
#
#-Version
#
#   -Mice Version 1.0.0, 18-APR-2006, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#                            #####
#     ####    ####   ###### #     #   ####
#    #       #    #  #            #  #
#     ####   #       #####   #####    ####
#         #  #       #      #             #
#    #    #  #    #  #      #        #    #
#     ####    ####   ###### #######   ####
#
#   ephemeris time to spacecraft_clock string
#
################################################################################
#-Abstract
#
#   sce2s converts an epoch specified as ephemeris seconds
#   past J2000 (ET) value describing a date to a character string
#   representation of a spacecraft clock value (SCLK).
#
#-I/O
#
#   Given:
#
#      sc   the scalar integer NAIF ID of the spacecraft clock whose
#           encoded SCLK value at the epoch 'et' is desired
#
#      et   the double precision scalar or double precision 1xN array of
#           epochs specified as ephemeris seconds past J2000
#
#   the call:
#
#      sclkch = sce2s( sc, et )
#
#   returns:
#
#      sclkch   the scalar string or NXM character array representation(s)
#               of spacecraft 'sc' clock count  that corresponds to 'et'
#
#               'sclkch' returns with the same vectorization measure (N)
#               as 'et'.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine sce2s_c.
#
#   MICE.REQ
#   SCLK.REQ
#   TIME.REQ
#
    function # sce2s
#       (sclkch::AbstractString) =   # Ptr{SpiceChar}
        sce2s(
            sc::Int64, # SpiceInt
            et::Float64) # SpiceDouble

#       enforce input array sizes
#       allocate the output parameters
        sclkch_array = Array{UInt8}(256)
        sclkch_ptr = pointer( sclkch_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:sce2s_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceDouble,SpiceInt,Ptr{SpiceChar}),sc,et,sclklen,sclkch)
        ccall((:sce2s_c,libNasaSpice),Void,
            (Int64,Float64,Int64,Ptr{SpiceChar}),
            sc,et,255,sclkch_ptr)

#       unpack any structures and transpose back any returned arrays
        sclkch = bytestring( sclkch_ptr )
        return (sclkch)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Load the leapseconds kernel for time conversion.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Assign values for the spacecraft ID (Voyager2),
#      % SCLK kernel.
#      %
#      SC         = -32;
#      SCLK       = '/kernels/voyager2/sclk/vg200004.tsc';
#      event_time = '1979 JUL 05 21:50:21.23379';
#
#      %
#      % Load the SCLK kernel.
#      %
#      cspice_furnsh( SCLK )
#
#      %
#      % Convert the time string to ephemeris time.
#      %
#      et = cspice_str2et( event_time );
#
#      %
#      % Convert the ephemeris time to the corresponding
#      % SCLK string appropriate for this spacecraft
#      %
#      sclkch = sce2s( SC, et );
#
#      disp( 'Scalar' )
#      txt = sprintf( 'Ephemeris time : %20.8f',  et );
#      disp( txt )
#
#      txt = sprintf( 'SCLK string    : %s', sclkch );
#      disp( txt )
#
#      disp(' ')
#
#      %
#      % Vectorized use, a vector of UTC times.
#      %
#      event_time =  strvcat( '1979 JUL 05 22:50:21.23379', ...
#                             '1979 JUL 05 23:50:21.23379', ...
#                             '1979 JUL 06 00:50:21.23379' );
#
#      %
#      % Convert the time strings to ET.
#      %
#      et = cspice_str2et( event_time );
#
#      %
#      % Convert the ephemeris time to the corresponding
#      % SCLK string appropriate for this spacecraft
#      %
#      sclkch = sce2s( SC, et );
#
#      disp( 'Vector:' )
#      for i=1:3
#
#         txt = sprintf( 'Ephemeris time : %20.8f',  et(i) );
#         disp( txt )
#
#         txt = sprintf( 'SCLK string    : %s', sclkch(i,:) );
#         disp( txt )
#         disp (' ')
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Scalar
#      Ephemeris time :  -646668528.58223021
#      SCLK string    : 2/20538:39:768
#
#      Vector:
#      Ephemeris time :  -646664928.58223140
#      SCLK string    : 2/20539:54:768
#
#      Ephemeris time :  -646661328.58223248
#      SCLK string    : 2/20541:09:768
#
#      Ephemeris time :  -646657728.58223367
#      SCLK string    : 2/20542:24:768
#
#-Version
#
#   -Mice Version 1.0.0, 18-APR-2006, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####   #####   #    #   ####   ######   ####
#    #       #    #  #   #   #       #       #
#     ####   #    #  ####     ####   #####    ####
#         #  #####   #  #         #  #            #
#    #    #  #       #   #   #    #  #       #    #
#     ####   #       #    #   ####   #        ####
#
#   select spk file and segment
#
################################################################################
#-Abstract
#
#   spksfs searches through loaded SPK files to find the
#   highest-priority segment applicable to the body and time specified.
#
#-I/O
#
#   Given:
#
#      body   the SPK ID code of an ephemeris object, typically a solar
#             system body.
#
#             [1,1] = size(dc); int32 = class(body)
#
#      et     the time, in seconds past the epoch J2000 TDB.
#
#             [1,1] = size(et); double = class(et)
#
#   the call:
#
#      [handle, descr, ident, found] = spksfs( body, et)
#
#   returns:
#
#      handle   the handle of the SPK file containing a located segment.
#
#               [1,1] = size(handle); int32 = class(handle)
#
#      descr    the descriptor of a located SPK segment.
#
#               [5,1] = size(descr); double = class(descr)
#
#      ident    the string SPK segment identifier of a located SPK segment.
#
#               [1,c1] = size(ident); char = class(ident)
#
#      found    indicates whether a requested segment was found or not.
#               The other output arguments are valid only if `found'
#               is set to true.
#
#               [1,1] = size(found); logical = class(found)
#
#-Particulars
#
#   This routine finds the highest-priority segment, in any loaded
#   SPK file, such that the segment provides data for the specified
#   body and epoch.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine spksfs_c.
#
#   MICE.REQ
#   SPK.REQ
#
    function # spksfs
#       (handle::Int64,  # Ptr{SpiceInt}
#        descr::Array{Float64}(5),  # Array_5_SpiceDouble
#        ident::AbstractString,  # Ptr{SpiceChar}
#        found::Int32) =   # Ptr{SpiceBoolean}
        spksfs(
            body::Int64, # SpiceInt
            et::Float64) # SpiceDouble

#       enforce input array sizes
#       allocate the output parameters
        handle = Array{Int64}(1);  # Ptr{SpiceInt}
        handle_ptr = pointer(handle)
        descr = Array{Float64}(5);  # Array_5_SpiceDouble
        descr_ptr = pointer(descr)
        ident_array = Array{UInt8}(256)
        ident_ptr = pointer( ident_array )
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:spksfs_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceInt,SpiceDouble,SpiceInt,Ptr{SpiceInt},Array_5_SpiceDouble,Ptr{SpiceChar},Ptr{SpiceBoolean}),
# body,et,idlen,handle,descr,ident,found)
        ccall((:spksfs_c,libNasaSpice),Void,
            (Int64,Float64,Int64,Ptr{Int64},Ptr{Float64},Ptr{SpiceChar},Ptr{Int32}),
            body,et255,255,handle_ptr,descr_ptr,ident_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        ident = bytestring( ident_ptr )
        return (handle[1], descr', ident, convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#   In the following code fragment, an SPK file is searched for
#   a segment containing ephemeris data for the Jupiter system
#   barycenter at a particular epoch. Using this segment,
#   states of the Jupiter system barycenter relative to the
#   solar system barycenter are evaluated at a sequence of times.
#
#   This method of state computation minimizes the number of
#   segment searches required to obtain requested data, but
#   it bypasses the SPK subsystem's state chaining mechanism.
#
#      Use the meta-kernel shown below to load the required SPICE
#      kernels.
#
#         KPL/MK
#
#         File name: standard.tm
#
#         This meta-kernel is intended to support operation of SPICE
#         example programs. The kernels shown here should not be
#         assumed to contain adequate or correct versions of data
#         required by SPICE-based user applications.
#
#         In order for an application to use this meta-kernel, the
#         kernels referenced here must be present in the user's
#         current working directory.
#
#         The names and contents of the kernels referenced
#         by this meta-kernel are as follows:
#
#            File name                     Contents
#            ---------                     --------
#            de421.bsp                     Planetary ephemeris
#            pck00010.tpc                  Planet orientation and
#                                          radii
#            naif0010.tls                  Leapseconds
#
#         \begindata
#
#            KERNELS_TO_LOAD = ( 'de421.bsp',
#                                'pck00010.tpc',
#                                'naif0010.tls'  )
#
#         \begintext
#
#   Example:
#
#      %
#      % Local constants
#      %
#      META   =  'standard.tm';
#      ND     =  2;
#      NI     =  6;
#      TIMFMT =  'YYYY MON DD HR:MN:SC.######::TDB TDB';
#
#      %
#      % Load meta-kernel.
#      %
#      cspice_furnsh( META )
#
#      %
#      % Convert starting time to seconds past J2000 TDB.
#      %
#      timstr = '2012 APR 27 00:00:00.000 TDB';
#
#      et0 = cspice_str2et(timstr);
#
#      %
#      % Find a loaded segment for the Jupiter barycenter
#      % that covers `et0'.
#      %
#      body = 5;
#
#      [handle, descr, segid, found] = spksfs( body, et0);
#
#
#      if ~found
#         cspice_kclear
#         txt = sprintf( 'No SPK segment found for body %d at time %s', ...
#                         body, timstr );
#         error( txt )
#      end
#
#      %
#      % Unpack the descriptor of the current segment.
#      %
#      [dc, ic] = cspice_dafus( descr, ND, NI );
#
#      frname = cspice_frmnam( ic(3) );
#
#      fprintf( 'Body        = %d\n', ic(1) )
#      fprintf( 'Center      = %d\n', ic(2) )
#      fprintf( 'Frame       = %s\n', frname)
#      fprintf( 'Data type   = %d\n', ic(4) )
#      fprintf( 'Start ET    = %f\n', dc(1) )
#      fprintf( 'Stop ET     = %f\n', dc(2) )
#      fprintf( 'Segment ID  = %s\n\n', segid )
#
#
#      %
#      % Evaluate states at 10-second steps, starting at `et0'
#      % and continuing for 20 seconds.
#      %
#
#      for i=1:3
#
#         et = et0 + ( 10. * (i-1) );
#
#         %
#         % Convert `et' to a string for display.
#         %
#         outstr = cspice_timout( et, TIMFMT );
#
#         %
#         % Attempt to compute a state only if the segment's
#         % coverage interval contains `et'.
#         %
#         if ( et <= dc(2) )
#
#            %
#            % This segment has data at `et'. Evaluate the
#            % state of the target relative to its center
#            % of motion.
#            %
#            [ref_id, state, center] = cspice_spkpvn( handle, descr, et );
#
#            %
#            %  Display the time and state.
#            %
#            fprintf( '\n%s\n', outstr )
#            fprintf( 'Position X (km):   %24.17f\n', state(1) )
#            fprintf( 'Position Y (km):   %24.17f\n', state(2) )
#            fprintf( 'Position Z (km):   %24.17f\n', state(3) )
#            fprintf( 'Velocity X (km):   %24.17f\n', state(4) )
#            fprintf( 'Velocity X (km):   %24.17f\n', state(5) )
#            fprintf( 'Velocity X (km):   %24.17f\n', state(6) )
#
#         else
#
#            cspice_kclear
#            txt = sprintf( 'No data found for body %d at time %s', ...
#                         body, outstr );
#            error( txt )
#
#         end
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in IDL due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Body        = 5
#      Center      = 0
#      Frame       = J2000
#      Data type   = 2
#      Start ET    = -3169195200.000000
#      Stop ET     = 1696852800.000000
#      Segment ID  = DE-0421LE-0421
#
#
#      2012 APR 27 00:00:00.000000 TDB
#      Position X (km):   464528993.98216485977172852
#      Position Y (km):   541513126.15685200691223145
#      Position Z (km):   220785135.62462940812110901
#      Velocity X (km):      -10.38685648307654930
#      Velocity X (km):        7.95324700713742416
#      Velocity X (km):        3.66185835431306517
#
#      2012 APR 27 00:00:10.000000 TDB
#      Position X (km):   464528890.11359262466430664
#      Position Y (km):   541513205.68931341171264648
#      Position Z (km):   220785172.24320945143699646
#      Velocity X (km):      -10.38685796160419272
#      Velocity X (km):        7.95324528430304944
#      Velocity X (km):        3.66185765185608103
#
#      2012 APR 27 00:00:20.000000 TDB
#      Position X (km):   464528786.24500560760498047
#      Position Y (km):   541513285.22175765037536621
#      Position Z (km):   220785208.86178246140480042
#      Velocity X (km):      -10.38685944013147910
#      Velocity X (km):        7.95324356146845002
#      Velocity X (km):        3.66185694939899253
#
#-Version
#
#   -Mice Version 1.0.0, 30-OCT-2012, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     ####    #####  #####    ####    ####   #
#    #          #    #    #  #    #  #    #  #
#     ####      #    #    #  #    #  #    #  #
#         #     #    #####   #    #  #    #  #
#    #    #     #    #       #    #  #    #  #
#     ####      #    #        ####    ####   ######
#
#   Retrieve a continued string value from the kernel pool
#
################################################################################
#-Abstract
#
#   stpool retrieves the 'nth' string from the kernel pool variable
#   'item' , where the string may be continued across several components
#   of the kernel pool variable.
#
#-I/O
#
#   Given:
#
#      item     the scalar string name of a kernel pool variable for
#               which the caller wants to retrieve a full (potentially
#               continued) string
#
#      nth      the scalar integer index of the string to retrieve from
#               the kernel pool variable 'item' (index array base 1)
#
#      contin   a sequence of characters which (if they appear as the
#               last non-blank sequence of characters in a component of a
#               value of a kernel pool variable) act as a continuation
#               marker:  the marker indicates that the string associated
#               with the component containing it is continued into the
#               next literal component of the kernel pool variable
#
#               If 'contin' is a blank, all of the components of 'item'
#               will return as a single string.
#
#   the call:
#
#      [string, found] = stpool( item, nth, contin )
#
#   returns:
#
#      string   the 'nth' scalar string value corresponding to
#               the kernel pool variable specified by 'item'
#
#      found    a scalar boolean indicating true if the request
#               to retrieve the 'nth' string associated with 'item'
#               succeeds, false if not.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine stpool_c.
#
#   MICE.REQ
#   KERNEL.REQ
#
    function # stpool
#       (string::AbstractString,  # Ptr{SpiceChar}
#        found::Int32) =   # Ptr{SpiceBoolean}
        stpool(
            item::AbstractString, # Ptr{ConstSpiceChar}
            nth::Int64, # SpiceInt
            contin::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        string_array = Array{UInt8}(256)
        string_ptr = pointer( string_array )
        found = Array{Int32}(1);  # Ptr{SpiceBoolean}
        found_ptr = pointer(found)

#       make transposed copies of all input arrays and their pointers

#       ccall((:stpool_c,"/home/don/.julia/v0.3/cspice.so"),Void,(Ptr{ConstSpiceChar},SpiceInt,Ptr{ConstSpiceChar},SpiceInt,Ptr{SpiceChar},Ptr{SpiceInt},Ptr{SpiceBoolean}),
# item,nth,contin,lenout,string,size,found)
        ccall((:stpool_c,libNasaSpice),Void,
            (Ptr{UInt8},Int64,Ptr{UInt8},Int64,Ptr{SpiceChar},Ptr{Int32}),
            item,nth,contin,255,string_ptr,found_ptr)

#       unpack any structures and transpose back any returned arrays
        string = bytestring( string_ptr )
        return (string, convert( Bool, found[1] ))
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Load a kernel containing the variable assignment:
#      %
#      % LONG_VAL = ( 'This is part of the first component //'
#      %             'that needs more than one line when //'
#      %             'inserting it into the kernel pool.'
#      %             'This is the second string that is split //'
#      %             'up as several components of a kernel pool //'
#      %             'variable.' )
#      %
#      cspice_furnsh( 'pool_t.ker' )
#
#      %
#      % Retrieve the 'nth' entry for kernel pool variable
#      % 'LONG_VAL' to 'string'.
#      %
#      ITEM   = 'LONG_VAL';
#      CONTIN = '//';
#
#      for nth=1:3
#
#         [string, found] = stpool( ITEM, nth, CONTIN );
#
#         if ( found )
#
#            fprintf( ['Found index = %d component of kernel variable %s ' ...
#                     'in the kernel pool.\n\n'], nth, ITEM)
#
#            fprintf( 'AbstractString = ``%s``\n\n', string )
#
#         else
#
#            fprintf( ['No index = %d component of kernel variable %s ' ...
#                      'found in the kernel pool.\n'], nth, ITEM)
#
#         end
#
#      end
#
#      %
#      % It's always good form to unload kernels after use,
#      % particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs (approximately):
#
#      Found index = 1 component of kernel variable LONG_VAL in the
#      kernel pool.
#
#      AbstractString = ``This is part of the first component that needs more
#      than one line when inserting it into the kernel pool.``
#
#      Found index = 2 component of kernel variable LONG_VAL in the
#      kernel pool.
#
#      AbstractString = ``This is the second string that is split up as several
#      components of a kernel pool variable.``
#
#      No index = 3 component of kernel variable LONG_VAL found in the
#      kernel pool.
#
#-Version
#
#   -Mice Version 1.1.0, 10-MAY-2011, EDW (JPL)
#
#      "logical" call replaced with "zzmice_logical."
#
#   -Mice Version 1.0.0, 26-SEP-2007, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


################################################################################
#
#     #####     #    #    #   ####   #    #   #####
#       #       #    ##  ##  #    #  #    #     #
#       #       #    # ## #  #    #  #    #     #
#       #       #    #    #  #    #  #    #     #
#       #       #    #    #  #    #  #    #     #
#       #       #    #    #   ####    ####      #
#
#   Convert and format d.p. seconds past J2000 as a string
#
################################################################################
#-Abstract
#
#   timout converts an input epoch represented in TDB seconds
#   past the TDB epoch of J2000 to a character string formatted to
#   the specifications of a user's format picture.
#
#-I/O
#
#   Given:
#
#     et       a double precision scalar or 1xN array of time values
#              in seconds past the ephemeris epoch J2000.
#
#     pictur   a scalar string that specifies how the output should be
#              presented.  The string is made up of various markers
#              that stand for various components associated with
#              a time.
#
#   the call:
#
#      output = timout( et, pictur )
#
#   returns:
#
#      output   the scalar string or NxM character array of output time strings
#               equivalent to the input epoch 'et' in the format specified
#               by 'pictur'
#
#               'output' returns with the same vectorization measure (N)
#                as 'et'.
#
#-Particulars
#
#   None.
#
#-Required Reading
#
#   For important details concerning this module's function, please refer to
#   the CSPICE routine timout_c.
#
#   MICE.REQ
#   TIME.REQ
#
    function # timout
#       (output::AbstractString) =   # Ptr{SpiceChar}
        timout(
            et::Float64, # SpiceDouble
            pictur::AbstractString) # Ptr{ConstSpiceChar}

#       enforce input array sizes
#       allocate the output parameters
        output_array = Array{UInt8}(256)
        output_ptr = pointer( output_array )

#       make transposed copies of all input arrays and their pointers

#       ccall((:timout_c,"/home/don/.julia/v0.3/cspice.so"),Void,(SpiceDouble,Ptr{ConstSpiceChar},SpiceInt,Ptr{SpiceChar}),et,pictur,lenout,output)
        ccall((:timout_c,libNasaSpice),Void,
            (Float64,Ptr{UInt8},Int64,Ptr{SpiceChar}),
            et,pictur,255,output_ptr)

#       unpack any structures and transpose back any returned arrays
        output = bytestring( output_ptr )
        return (output)
    end
#-Examples
#
#   Any numerical results shown for this example may differ between
#   platforms as the results depend on the SPICE kernels used as input
#   and the machine specific arithmetic implementation.
#
#      %
#      % Given a sample with the format of the UNIX date string
#      % local to California, create a SPICE time picture for use
#      % in timout.
#      %
#      sample = 'Thu Oct 1 11:11:11 PDT 1111';
#
#      %
#      % Load a leapseconds kernel file.
#      %
#      cspice_furnsh( 'standard.tm' )
#
#      %
#      % Create the pic string.
#      %
#      [ pic, ok, xerror ] = cspice_tpictr( sample );
#
#      %
#      % Check the error flag, 'ok', for problems.
#      %
#      if ( ~ok  )
#         error( xerror )
#      end
#
#      %
#      % Convert an ephemeris time to the 'pic' format.
#      %
#      % Using the ET representation for: Dec 25 2005, 1:15:00 AM UTC
#      %
#      et = 188745364.;
#
#      output = timout( et, pic );
#
#      disp( 'Scalar: ' )
#
#      txt = sprintf( 'ET              : %16.8f', et );
#      disp( txt )
#
#      disp( ['Converted output: ' output] )
#      disp( ' ' )
#
#      %
#      % Create an array of ephemeris times beginning
#      % at 188745364 with graduations of 10000.0
#      % ephemeris seconds.
#      %
#      et=[0:4] * 10000. + 188745364;
#
#      %
#      % Convert the array of ephemeris times 'et' to an
#      % array of time strings, 'output', in 'pic' format.
#      %
#      output = timout( et, pic );
#
#      disp( 'Vector:' )
#      for i=1:5
#         txt = sprintf( 'ET              : %16.8f', et(i) );
#         disp( txt)
#
#         disp( ['Converted output: ' output(i,:) ]  )
#         disp( ' ' )
#      end
#
#      %
#      %  It's always good form to unload kernels after use,
#      %  particularly in MATLAB due to data persistence.
#      %
#      cspice_kclear
#
#   MATLAB outputs:
#
#      Scalar:
#      ET              : 188745364.00000000
#      Converted output: Sat Dec 24 18:14:59 PDT 2005
#
#      Vector:
#      ET              : 188745364.00000000
#      Converted output: Sat Dec 24 18:14:59 PDT 2005
#
#      ET              : 188755364.00000000
#      Converted output: Sat Dec 24 21:01:39 PDT 2005
#
#      ET              : 188765364.00000000
#      Converted output: Sat Dec 24 23:48:19 PDT 2005
#
#      ET              : 188775364.00000000
#      Converted output: Sun Dec 25 02:34:59 PDT 2005
#
#      ET              : 188785364.00000000
#      Converted output: Sun Dec 25 05:21:39 PDT 2005
#
#-Version
#
#   -Mice Version 1.0.0, 22-NOV-2005, EDW (JPL)
#
#-Disclaimer
#
#   THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
#   CALIFORNIA  INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
#   GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
#   ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
#   PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED
#   "AS-IS" TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING
#   ANY WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR
#   A PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
#   SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
#   SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
#
#   IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY,
#   OR NASA BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING,
#   BUT NOT LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF
#   ANY KIND, INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY
#   AND LOST PROFITS, REGARDLESS OF WHETHER CALTECH, JPL, OR
#   NASA BE ADVISED, HAVE REASON TO KNOW, OR, IN FACT, SHALL
#   KNOW OF THE POSSIBILITY.
#
#   RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE
#   OF THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO
#   INDEMNIFY CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING
#   FROM THE ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
#
################################################################################


