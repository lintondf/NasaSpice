import Base.zero

const unix = 1
const linux = 1
const SPICETRUE = 1
const SPICEFALSE = 0
const ARROWLEN = 5
const SPICE_ERROR_LMSGLN = 1841
const SPICE_ERROR_SMSGLN = 26
const SPICE_ERROR_XMSGLN = 81
const SPICE_ERROR_MODLEN = 33
const SPICE_ERROR_MAXMOD = 100

# Skipping MacroDefinition: SPICE_ERROR_TRCLEN ( ( SPICE_ERROR_MAXMOD * ( SPICE_ERROR_MODLEN - 1 ) ) + ( ARROWLEN * ( SPICE_ERROR_MAXMOD - 1 ) ) + 1 )

const SPICE_EK_CNAMSZ = 32
const SPICE_EK_CSTRLN = SPICE_EK_CNAMSZ + 1
const SPICE_EK_TNAMSZ = 64
const SPICE_EK_TSTRLN = SPICE_EK_TNAMSZ + 1
const SPICE_EK_MXCLSG = 100
const SPICE_EK_TYPLEN = 4
const SPICE_EK_MAXQRY = 2000
const SPICE_EK_MAXQSEL = 50
const SPICE_EK_MAXQTAB = 10
const SPICE_EK_MAXQCON = 1000
const SPICE_EK_MAXQJOIN = 10
const SPICE_EK_MAXQJCON = 100
const SPICE_EK_MAXQORD = 10
const SPICE_EK_MAXQTOK = 500
const SPICE_EK_MAXQNUM = 100
const SPICE_EK_MAXQCLN = SPICE_EK_MAXQRY
const SPICE_EK_MAXQSTR = 1024
const SPICE_EK_VARSIZ = -1
const SPICE_NFRAME_NINERT = 21
const SPICE_NFRAME_NNINRT = 105
const SPICE_FRMTYP_INERTL = 1
const SPICE_FRMTYP_PCK = 2
const SPICE_FRMTYP_CK = 3
const SPICE_FRMTYP_TK = 4
const SPICE_FRMTYP_DYN = 5
const SPICE_FRMTYP_ALL = -1
const SPICE_CELL_CTRLSZ = 6

# Skipping MacroDefinition: SPICECHAR_CELL ( name , size , length ) static SpiceChar SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ + size ] [ length ] ; static SpiceCell name = { SPICE_CHR , length , size , 0 , SPICETRUE , SPICEFALSE , SPICEFALSE , ( void * ) & ( SPICE_CELL_ ## name ) , ( void * ) & ( SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ ] ) }
# Skipping MacroDefinition: SPICEDOUBLE_CELL ( name , size ) static SpiceDouble SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ + size ] ; static SpiceCell name = { SPICE_DP , 0 , size , 0 , SPICETRUE , SPICEFALSE , SPICEFALSE , ( void * ) & ( SPICE_CELL_ ## name ) , ( void * ) & ( SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ ] ) }
# Skipping MacroDefinition: SPICEINT_CELL ( name , size ) static SpiceInt SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ + size ] ; static SpiceCell name = { SPICE_INT , 0 , size , 0 , SPICETRUE , SPICEFALSE , SPICEFALSE , ( void * ) & ( SPICE_CELL_ ## name ) , ( void * ) & ( SPICE_CELL_ ## name [ SPICE_CELL_CTRLSZ ] ) }
# Skipping MacroDefinition: SPICE_CELL_ELEM_C ( cell , i ) ( ( ( SpiceChar * ) ( cell ) -> data ) + ( i ) * ( ( cell ) -> length ) )
# Skipping MacroDefinition: SPICE_CELL_ELEM_D ( cell , i ) ( ( ( SpiceDouble * ) ( cell ) -> data ) [ ( i ) ] )
# Skipping MacroDefinition: SPICE_CELL_ELEM_I ( cell , i ) ( ( ( SpiceInt * ) ( cell ) -> data ) [ ( i ) ] )
# Skipping MacroDefinition: SPICE_CELL_GET_C ( cell , i , lenout , item ) { SpiceInt nBytes ; nBytes = brckti_c ( ( cell ) -> length , 0 , ( lenout - 1 ) ) * sizeof ( SpiceChar ) ; memmove ( ( item ) , SPICE_CELL_ELEM_C ( ( cell ) , ( i ) ) , nBytes ) ; item [ nBytes ] = NULLCHAR ; }
# Skipping MacroDefinition: SPICE_CELL_GET_D ( cell , i , item ) ( ( * item ) = ( ( SpiceDouble * ) ( cell ) -> data ) [ i ] )
# Skipping MacroDefinition: SPICE_CELL_GET_I ( cell , i , item ) ( ( * item ) = ( ( SpiceInt * ) ( cell ) -> data ) [ i ] )
# Skipping MacroDefinition: SPICE_CELL_SET_C ( item , i , cell ) { SpiceChar * sPtr ; SpiceInt nBytes ; nBytes = brckti_c ( strlen ( item ) , 0 , ( cell ) -> length - 1 ) * sizeof ( SpiceChar ) ; sPtr = SPICE_CELL_ELEM_C ( ( cell ) , ( i ) ) ; memmove ( sPtr , ( item ) , nBytes ) ; sPtr [ nBytes ] = NULLCHAR ; }
# Skipping MacroDefinition: SPICE_CELL_SET_D ( item , i , cell ) ( ( ( SpiceDouble * ) ( cell ) -> data ) [ i ] = ( item ) )
# Skipping MacroDefinition: SPICE_CELL_SET_I ( item , i , cell ) ( ( ( SpiceInt * ) ( cell ) -> data ) [ i ] = ( item ) )

const SPICE_GF_NWMAX = 15
const SPICE_GF_NWDIST = 5
const SPICE_GF_NWILUM = 5
const SPICE_GF_NWSEP = 5
const SPICE_GF_NWRR = 5
const SPICE_GF_NWPA = 5
const SPICE_GF_MAXVRT = 10000
const SPICE_GF_CIRFOV = "CIRCLE"
const SPICE_GF_ELLFOV = "ELLIPSE"
const SPICE_GF_POLFOV = "POLYGON"
const SPICE_GF_RECFOV = "RECTANGLE"
const SPICE_GF_SHPLEN = 10
const SPICE_GF_MARGIN = 1.0e-12
const SPICE_GF_ANNULR = "ANNULAR"
const SPICE_GF_ANY = "ANY"
const SPICE_GF_FULL = "FULL"
const SPICE_GF_PARTL = "PARTIAL"
const SPICE_GF_EDSHAP = "ELLIPSOID"
const SPICE_GF_PTSHAP = "POINT"
const SPICE_GF_RYSHAP = "RAY"
const SPICE_GF_SPSHAP = "SPHERE"
const SPICE_GF_ADDWIN = 1.0
const SPICE_GF_CNVTOL = 1.0e-6
const SPICE_GFEVNT_MAXPAR = 10
const SPICE_OCCULT_TOTAL1 = -3
const SPICE_OCCULT_ANNLR1 = -2
const SPICE_OCCULT_PARTL1 = -1
const SPICE_OCCULT_NOOCC = 0
const SPICE_OCCULT_PARTL2 = 1
const SPICE_OCCULT_ANNLR2 = 2
const SPICE_OCCULT_TOTAL2 = 3
## # const dpstrf_ = zz_dpstrf_
## #const pi_ = zz_pi_
## #const vnorm_ = zz_vnorm_
## #const vdist_ = zz_vdist_
## const CONST_BOOL = $(Expr(:incomplete, "incomplete: premature end of input"))
## const CONST_ELLIPSE = $(Expr(:incomplete, "incomplete: premature end of input"))
## const CONST_IVEC = $(Expr(:incomplete, "incomplete: premature end of input"))

# Skipping MacroDefinition: CONST_MAT ConstSpiceDouble ( * ) [ 3 ]
# Skipping MacroDefinition: CONST_MAT2 ConstSpiceDouble ( * ) [ 2 ]
# Skipping MacroDefinition: CONST_MAT6 ConstSpiceDouble ( * ) [ 6 ]

## const CONST_PLANE = $(Expr(:incomplete, "incomplete: premature end of input"))

# Skipping MacroDefinition: CONST_VEC3 ConstSpiceDouble ( * ) [ 3 ]
# Skipping MacroDefinition: CONST_VEC4 ConstSpiceDouble ( * ) [ 4 ]

## const CONST_STR = $(Expr(:incomplete, "incomplete: premature end of input"))
## const CONST_VEC = $(Expr(:incomplete, "incomplete: premature end of input"))

# Skipping MacroDefinition: CONST_VOID const void *
# Skipping MacroDefinition: axisar_c ( axis , angle , r ) ( axisar_c ( CONST_VEC ( axis ) , ( angle ) , ( r ) ) )
# Skipping MacroDefinition: bschoc_c ( value , ndim , lenvals , array , order ) ( bschoc_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) , CONST_IVEC ( order ) ) )
# Skipping MacroDefinition: bschoi_c ( value , ndim , array , order ) ( bschoi_c ( ( value ) , ( ndim ) , CONST_IVEC ( array ) , CONST_IVEC ( order ) ) )
# Skipping MacroDefinition: bsrchc_c ( value , ndim , lenvals , array ) ( bsrchc_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) ) )
# Skipping MacroDefinition: bsrchd_c ( value , ndim , array ) ( bsrchd_c ( ( value ) , ( ndim ) , CONST_VEC ( array ) ) )
# Skipping MacroDefinition: bsrchi_c ( value , ndim , array ) ( bsrchi_c ( ( value ) , ( ndim ) , CONST_IVEC ( array ) ) )
# Skipping MacroDefinition: ckw01_c ( handle , begtim , endtim , inst , ref , avflag , segid , nrec , sclkdp , quats , avvs ) ( ckw01_c ( ( handle ) , ( begtim ) , ( endtim ) , ( inst ) , CONST_STR ( ref ) , ( avflag ) , CONST_STR ( segid ) , ( nrec ) , CONST_VEC ( sclkdp ) , CONST_VEC4 ( quats ) , CONST_VEC3 ( avvs ) ) )
# Skipping MacroDefinition: ckw02_c ( handle , begtim , endtim , inst , ref , segid , nrec , start , stop , quats , avvs , rates ) ( ckw02_c ( ( handle ) , ( begtim ) , ( endtim ) , ( inst ) , CONST_STR ( ref ) , CONST_STR ( segid ) , ( nrec ) , CONST_VEC ( start ) , CONST_VEC ( stop ) , CONST_VEC4 ( quats ) , CONST_VEC3 ( avvs ) , CONST_VEC ( rates ) ) )
# Skipping MacroDefinition: ckw03_c ( handle , begtim , endtim , inst , ref , avflag , segid , nrec , sclkdp , quats , avvs , nints , starts ) ( ckw03_c ( ( handle ) , ( begtim ) , ( endtim ) , ( inst ) , CONST_STR ( ref ) , ( avflag ) , CONST_STR ( segid ) , ( nrec ) , CONST_VEC ( sclkdp ) , CONST_VEC4 ( quats ) , CONST_VEC3 ( avvs ) , ( nints ) , CONST_VEC ( starts ) ) )
# Skipping MacroDefinition: ckw05_c ( handle , subtyp , degree , begtim , endtim , inst , ref , avflag , segid , n , sclkdp , packts , rate , nints , starts ) ( ckw05_c ( ( handle ) , ( subtyp ) , ( degree ) , ( begtim ) , ( endtim ) , ( inst ) , CONST_STR ( ref ) , ( avflag ) , CONST_STR ( segid ) , ( n ) , CONST_VEC ( sclkdp ) , CONST_VOID ( packts ) , ( rate ) , ( nints ) , CONST_VEC ( starts ) ) )
# Skipping MacroDefinition: cgv2el_c ( center , vec1 , vec2 , ellipse ) ( cgv2el_c ( CONST_VEC ( center ) , CONST_VEC ( vec1 ) , CONST_VEC ( vec2 ) , ( ellipse ) ) )
# Skipping MacroDefinition: conics_c ( elts , et , state ) ( conics_c ( CONST_VEC ( elts ) , ( et ) , ( state ) ) )
# Skipping MacroDefinition: dafps_c ( nd , ni , dc , ic , sum ) ( dafps_c ( ( nd ) , ( ni ) , CONST_VEC ( dc ) , CONST_IVEC ( ic ) , ( sum ) ) )
# Skipping MacroDefinition: dafrs_c ( sum ) ( dafrs_c ( CONST_VEC ( sum ) ) )
# Skipping MacroDefinition: dafus_c ( sum , nd , ni , dc , ic ) ( dafus_c ( CONST_VEC ( sum ) , ( nd ) , ( ni ) , ( dc ) , ( ic ) ) )
# Skipping MacroDefinition: dasac_c ( handle , n , buflen , buffer ) ( dasac_c ( ( handle ) , ( n ) , ( buflen ) , CONST_VOID ( buffer ) ) )
# Skipping MacroDefinition: det_c ( m1 ) ( det_c ( CONST_MAT ( m1 ) ) )
# Skipping MacroDefinition: diags2_c ( symmat , diag , rotate ) ( diags2_c ( CONST_MAT2 ( symmat ) , ( diag ) , ( rotate ) ) )
# Skipping MacroDefinition: dvdot_c ( s1 , s2 ) ( dvdot_c ( CONST_VEC ( s1 ) , CONST_VEC ( s2 ) ) )
# Skipping MacroDefinition: dvhat_c ( v1 , v2 ) ( dvhat_c ( CONST_VEC ( v1 ) , ( v2 ) ) )
# Skipping MacroDefinition: dvsep_c ( s1 , s2 ) ( dvsep_c ( CONST_VEC ( s1 ) , CONST_VEC ( s2 ) ) )
# Skipping MacroDefinition: edlimb_c ( a , b , c , viewpt , limb ) ( edlimb_c ( ( a ) , ( b ) , ( c ) , CONST_VEC ( viewpt ) , ( limb ) ) )
# Skipping MacroDefinition: ekacec_c ( handle , segno , recno , column , nvals , vallen , cvals , isnull ) ( ekacec_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , ( vallen ) , CONST_VOID ( cvals ) , ( isnull ) ) )
# Skipping MacroDefinition: ekaced_c ( handle , segno , recno , column , nvals , dvals , isnull ) ( ekaced_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , CONST_VEC ( dvals ) , ( isnull ) ) )
# Skipping MacroDefinition: ekacei_c ( handle , segno , recno , column , nvals , ivals , isnull ) ( ekacei_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , CONST_IVEC ( ivals ) , ( isnull ) ) )
# Skipping MacroDefinition: ekaclc_c ( handle , segno , column , vallen , cvals , entszs , nlflgs , rcptrs , wkindx ) ( ekaclc_c ( ( handle ) , ( segno ) , ( column ) , ( vallen ) , CONST_VOID ( cvals ) , CONST_IVEC ( entszs ) , CONST_BOOL ( nlflgs ) , CONST_IVEC ( rcptrs ) , ( wkindx ) ) )
# Skipping MacroDefinition: ekacld_c ( handle , segno , column , dvals , entszs , nlflgs , rcptrs , wkindx ) ( ekacld_c ( ( handle ) , ( segno ) , ( column ) , CONST_VEC ( dvals ) , CONST_IVEC ( entszs ) , CONST_BOOL ( nlflgs ) , CONST_IVEC ( rcptrs ) , ( wkindx ) ) )
# Skipping MacroDefinition: ekacli_c ( handle , segno , column , ivals , entszs , nlflgs , rcptrs , wkindx ) ( ekacli_c ( ( handle ) , ( segno ) , ( column ) , CONST_IVEC ( ivals ) , CONST_IVEC ( entszs ) , CONST_BOOL ( nlflgs ) , CONST_IVEC ( rcptrs ) , ( wkindx ) ) )
# Skipping MacroDefinition: ekbseg_c ( handle , tabnam , ncols , cnmlen , cnames , declen , decls , segno ) ( ekbseg_c ( ( handle ) , ( tabnam ) , ( ncols ) , ( cnmlen ) , CONST_VOID ( cnames ) , ( declen ) , CONST_VOID ( decls ) , ( segno ) ) )
# Skipping MacroDefinition: ekifld_c ( handle , tabnam , ncols , nrows , cnmlen , cnames , declen , decls , segno , rcptrs ) ( ekifld_c ( ( handle ) , ( tabnam ) , ( ncols ) , ( nrows ) , ( cnmlen ) , CONST_VOID ( cnames ) , ( declen ) , CONST_VOID ( decls ) , ( segno ) , ( rcptrs ) ) )
# Skipping MacroDefinition: ekucec_c ( handle , segno , recno , column , nvals , vallen , cvals , isnull ) ( ekucec_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , ( vallen ) , CONST_VOID ( cvals ) , ( isnull ) ) )
# Skipping MacroDefinition: ekuced_c ( handle , segno , recno , column , nvals , dvals , isnull ) ( ekuced_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , CONST_VOID ( dvals ) , ( isnull ) ) )
# Skipping MacroDefinition: ekucei_c ( handle , segno , recno , column , nvals , ivals , isnull ) ( ekucei_c ( ( handle ) , ( segno ) , ( recno ) , CONST_STR ( column ) , ( nvals ) , CONST_VOID ( ivals ) , ( isnull ) ) )
# Skipping MacroDefinition: el2cgv_c ( ellipse , center , smajor , sminor ) ( el2cgv_c ( CONST_ELLIPSE ( ellipse ) , ( center ) , ( smajor ) , ( sminor ) ) )
# Skipping MacroDefinition: eqncpv_c ( et , epoch , eqel , rapol , decpol , state ) ( eqncpv_c ( ( et ) , ( epoch ) , CONST_VEC ( eqel ) , ( rapol ) , ( decpol ) , ( state ) ) )
# Skipping MacroDefinition: esrchc_c ( value , ndim , lenvals , array ) ( esrchc_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) ) )
# Skipping MacroDefinition: eul2xf_c ( eulang , axisa , axisb , axisc , xform ) ( eul2xf_c ( CONST_VEC ( eulang ) , ( axisa ) , ( axisb ) , ( axisc ) , ( xform ) ) )
# Skipping MacroDefinition: fovray_c ( inst , raydir , rframe , abcorr , observer , et , visible ) ( fovray_c ( ( inst ) , CONST_VEC ( raydir ) , ( rframe ) , ( abcorr ) , ( observer ) , ( et ) , ( visible ) ) )
# Skipping MacroDefinition: getelm_c ( frstyr , lineln , lines , epoch , elems ) ( getelm_c ( ( frstyr ) , ( lineln ) , CONST_VOID ( lines ) , ( epoch ) , ( elems ) ) )
# Skipping MacroDefinition: gfevnt_c ( udstep , udrefn , gquant , qnpars , lenvals , qpnams , qcpars , qdpars , qipars , qlpars , op , refval , tol , adjust , rpt , udrepi , udrepu , udrepf , nintvls , bail , udbail , cnfine , result ) ( gfevnt_c ( ( udstep ) , ( udrefn ) , ( gquant ) , ( qnpars ) , ( lenvals ) , CONST_VOID ( qpnams ) , CONST_VOID ( qcpars ) , ( qdpars ) , ( qipars ) , ( qlpars ) , ( op ) , ( refval ) , ( tol ) , ( adjust ) , ( rpt ) , ( udrepi ) , ( udrepu ) , ( udrepf ) , ( nintvls ) , ( bail ) , ( udbail ) , ( cnfine ) , ( result ) ) )
# Skipping MacroDefinition: gffove_c ( inst , tshape , raydir , target , tframe , abcorr , obsrvr , tol , udstep , udrefn , rpt , udrepi , udrepu , udrepf , bail , udbail , cnfine , result ) ( gffove_c ( ( inst ) , ( tshape ) , CONST_VEC ( raydir ) , ( target ) , ( tframe ) , ( abcorr ) , ( obsrvr ) , ( tol ) , ( udstep ) , ( udrefn ) , ( rpt ) , ( udrepi ) , ( udrepu ) , ( udrepf ) , ( bail ) , ( udbail ) , ( cnfine ) , ( result ) ) )
# Skipping MacroDefinition: gfrfov_c ( inst , raydir , rframe , abcorr , obsrvr , step , cnfine , result ) ( gfrfov_c ( ( inst ) , CONST_VEC ( raydir ) , ( rframe ) , ( abcorr ) , ( obsrvr ) , ( step ) , ( cnfine ) , ( result ) ) )
# Skipping MacroDefinition: gfsntc_c ( target , fixref , method , abcorr , obsrvr , dref , dvec , crdsys , coord , relate , refval , adjust , step , nintvls , cnfine , result ) ( gfsntc_c ( ( target ) , ( fixref ) , ( method ) , ( abcorr ) , ( obsrvr ) , ( dref ) , CONST_VEC ( dvec ) , ( crdsys ) , ( coord ) , ( relate ) , ( refval ) , ( adjust ) , ( step ) , ( nintvls ) , ( cnfine ) , ( result ) ) )
# Skipping MacroDefinition: illum_c ( target , et , abcorr , obsrvr , spoint , phase , solar , emissn ) ( illum_c ( ( target ) , ( et ) , ( abcorr ) , ( obsrvr ) , CONST_VEC ( spoint ) , ( phase ) , ( solar ) , ( emissn ) ) )
# Skipping MacroDefinition: ilumin_c ( method , target , et , fixref , abcorr , obsrvr , spoint , trgepc , srfvec , phase , solar , emissn ) ( ilumin_c ( ( method ) , ( target ) , ( et ) , ( fixref ) , ( abcorr ) , ( obsrvr ) , CONST_VEC ( spoint ) , ( trgepc ) , ( srfvec ) , ( phase ) , ( solar ) , ( emissn ) ) )
# Skipping MacroDefinition: inedpl_c ( a , b , c , plane , ellipse , found ) ( inedpl_c ( ( a ) , ( b ) , ( c ) , CONST_PLANE ( plane ) , ( ellipse ) , ( found ) ) )
# Skipping MacroDefinition: inrypl_c ( vertex , dir , plane , nxpts , xpt ) ( inrypl_c ( CONST_VEC ( vertex ) , CONST_VEC ( dir ) , CONST_PLANE ( plane ) , ( nxpts ) , ( xpt ) ) )
# Skipping MacroDefinition: invert_c ( m1 , m2 ) ( invert_c ( CONST_MAT ( m1 ) , ( m2 ) ) )
# Skipping MacroDefinition: invort_c ( m , mit ) ( invort_c ( CONST_MAT ( m ) , ( mit ) ) )
# Skipping MacroDefinition: isordv_c ( array , n ) ( isordv_c ( CONST_IVEC ( array ) , ( n ) ) )
# Skipping MacroDefinition: isrchc_c ( value , ndim , lenvals , array ) ( isrchc_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) ) )
# Skipping MacroDefinition: isrchd_c ( value , ndim , array ) ( isrchd_c ( ( value ) , ( ndim ) , CONST_VEC ( array ) ) )
# Skipping MacroDefinition: isrchi_c ( value , ndim , array ) ( isrchi_c ( ( value ) , ( ndim ) , CONST_IVEC ( array ) ) )
# Skipping MacroDefinition: isrot_c ( m , ntol , dtol ) ( isrot_c ( CONST_MAT ( m ) , ( ntol ) , ( dtol ) ) )
# Skipping MacroDefinition: lmpool_c ( cvals , lenvals , n ) ( lmpool_c ( CONST_VOID ( cvals ) , ( lenvals ) , ( n ) ) )
# Skipping MacroDefinition: lstltc_c ( value , ndim , lenvals , array ) ( lstltc_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) ) )
# Skipping MacroDefinition: lstled_c ( value , ndim , array ) ( lstled_c ( ( value ) , ( ndim ) , CONST_VEC ( array ) ) )
# Skipping MacroDefinition: lstlei_c ( value , ndim , array ) ( lstlei_c ( ( value ) , ( ndim ) , CONST_IVEC ( array ) ) )
# Skipping MacroDefinition: lstlec_c ( value , ndim , lenvals , array ) ( lstlec_c ( CONST_STR ( value ) , ( ndim ) , ( lenvals ) , CONST_VOID ( array ) ) )
# Skipping MacroDefinition: lstltd_c ( value , ndim , array ) ( lstltd_c ( ( value ) , ( ndim ) , CONST_VEC ( array ) ) )
# Skipping MacroDefinition: lstlti_c ( value , ndim , array ) ( lstlti_c ( ( value ) , ( ndim ) , CONST_IVEC ( array ) ) )
# Skipping MacroDefinition: m2eul_c ( r , axis3 , axis2 , axis1 , angle3 , angle2 , angle1 ) ( m2eul_c ( CONST_MAT ( r ) , ( axis3 ) , ( axis2 ) , ( axis1 ) , ( angle3 ) , ( angle2 ) , ( angle1 ) ) )
# Skipping MacroDefinition: m2q_c ( r , q ) ( m2q_c ( CONST_MAT ( r ) , ( q ) ) )
# Skipping MacroDefinition: mequ_c ( m1 , m2 ) ( mequ_c ( CONST_MAT ( m1 ) , m2 ) )
# Skipping MacroDefinition: mequg_c ( m1 , nr , nc , mout ) ( mequg_c ( CONST_MAT ( m1 ) , ( nr ) , ( nc ) , mout ) )
# Skipping MacroDefinition: mtxm_c ( m1 , m2 , mout ) ( mtxm_c ( CONST_MAT ( m1 ) , CONST_MAT ( m2 ) , ( mout ) ) )
# Skipping MacroDefinition: mtxmg_c ( m1 , m2 , ncol1 , nr1r2 , ncol2 , mout ) ( mtxmg_c ( CONST_MAT ( m1 ) , CONST_MAT ( m2 ) , ( ncol1 ) , ( nr1r2 ) , ( ncol2 ) , ( mout ) ) )
# Skipping MacroDefinition: mtxv_c ( m1 , vin , vout ) ( mtxv_c ( CONST_MAT ( m1 ) , CONST_VEC ( vin ) , ( vout ) ) )
# Skipping MacroDefinition: mtxvg_c ( m1 , v2 , nrow1 , nc1r2 , vout ) ( mtxvg_c ( CONST_VOID ( m1 ) , CONST_VOID ( v2 ) , ( nrow1 ) , ( nc1r2 ) , ( vout ) ) )
# Skipping MacroDefinition: mxm_c ( m1 , m2 , mout ) ( mxm_c ( CONST_MAT ( m1 ) , CONST_MAT ( m2 ) , ( mout ) ) )
# Skipping MacroDefinition: mxmg_c ( m1 , m2 , row1 , col1 , col2 , mout ) ( mxmg_c ( CONST_VOID ( m1 ) , CONST_VOID ( m2 ) , ( row1 ) , ( col1 ) , ( col2 ) , ( mout ) ) )
# Skipping MacroDefinition: mxmt_c ( m1 , m2 , mout ) ( mxmt_c ( CONST_MAT ( m1 ) , CONST_MAT ( m2 ) , ( mout ) ) )
# Skipping MacroDefinition: mxmtg_c ( m1 , m2 , nrow1 , nc1c2 , nrow2 , mout ) ( mxmtg_c ( CONST_VOID ( m1 ) , CONST_VOID ( m2 ) , ( nrow1 ) , ( nc1c2 ) , ( nrow2 ) , ( mout ) ) )
# Skipping MacroDefinition: mxv_c ( m1 , vin , vout ) ( mxv_c ( CONST_MAT ( m1 ) , CONST_VEC ( vin ) , ( vout ) ) )
# Skipping MacroDefinition: mxvg_c ( m1 , v2 , nrow1 , nc1r2 , vout ) ( mxvg_c ( CONST_VOID ( m1 ) , CONST_VOID ( v2 ) , ( nrow1 ) , ( nc1r2 ) , ( vout ) ) )
# Skipping MacroDefinition: nearpt_c ( positn , a , b , c , npoint , alt ) ( nearpt_c ( CONST_VEC ( positn ) , ( a ) , ( b ) , ( c ) , ( npoint ) , ( alt ) ) )
# Skipping MacroDefinition: npedln_c ( a , b , c , linept , linedr , pnear , dist ) ( npedln_c ( ( a ) , ( b ) , ( c ) , CONST_VEC ( linept ) , CONST_VEC ( linedr ) , ( pnear ) , ( dist ) ) )
# Skipping MacroDefinition: nplnpt_c ( linpt , lindir , point , pnear , dist ) ( nplnpt_c ( CONST_VEC ( linpt ) , CONST_VEC ( lindir ) , CONST_VEC ( point ) , ( pnear ) , ( dist ) ) )
# Skipping MacroDefinition: nvc2pl_c ( normal , constant , plane ) ( nvc2pl_c ( CONST_VEC ( normal ) , ( constant ) , ( plane ) ) )
# Skipping MacroDefinition: nvp2pl_c ( normal , point , plane ) ( nvp2pl_c ( CONST_VEC ( normal ) , CONST_VEC ( point ) , ( plane ) ) )
# Skipping MacroDefinition: orderc_c ( lenvals , array , ndim , iorder ) ( orderc_c ( ( lenvals ) , CONST_VOID ( array ) , ( ndim ) , ( iorder ) ) )
# Skipping MacroDefinition: orderd_c ( array , ndim , iorder ) ( orderd_c ( CONST_VEC ( array ) , ( ndim ) , ( iorder ) ) )
# Skipping MacroDefinition: orderi_c ( array , ndim , iorder ) ( orderi_c ( CONST_IVEC ( array ) , ( ndim ) , ( iorder ) ) )
# Skipping MacroDefinition: oscelt_c ( state , et , mu , elts ) ( oscelt_c ( CONST_VEC ( state ) , ( et ) , ( mu ) , ( elts ) ) )
# Skipping MacroDefinition: pcpool_c ( name , n , lenvals , cvals ) ( pcpool_c ( ( name ) , ( n ) , ( lenvals ) , CONST_VOID ( cvals ) ) )
# Skipping MacroDefinition: pdpool_c ( name , n , dvals ) ( pdpool_c ( ( name ) , ( n ) , CONST_VEC ( dvals ) ) )
# Skipping MacroDefinition: pipool_c ( name , n , ivals ) ( pipool_c ( ( name ) , ( n ) , CONST_IVEC ( ivals ) ) )
# Skipping MacroDefinition: pl2nvc_c ( plane , normal , constant ) ( pl2nvc_c ( CONST_PLANE ( plane ) , ( normal ) , ( constant ) ) )
# Skipping MacroDefinition: pl2nvp_c ( plane , normal , point ) ( pl2nvp_c ( CONST_PLANE ( plane ) , ( normal ) , ( point ) ) )
# Skipping MacroDefinition: pl2psv_c ( plane , point , span1 , span2 ) ( pl2psv_c ( CONST_PLANE ( plane ) , ( point ) , ( span1 ) , ( span2 ) ) )
# Skipping MacroDefinition: prop2b_c ( gm , pvinit , dt , pvprop ) ( prop2b_c ( ( gm ) , CONST_VEC ( pvinit ) , ( dt ) , ( pvprop ) ) )
# Skipping MacroDefinition: psv2pl_c ( point , span1 , span2 , plane ) ( psv2pl_c ( CONST_VEC ( point ) , CONST_VEC ( span1 ) , CONST_VEC ( span2 ) , ( plane ) ) )
# Skipping MacroDefinition: qdq2av_c ( q , dq , av ) ( qdq2av_c ( CONST_VEC ( q ) , CONST_VEC ( dq ) , ( av ) ) )
# Skipping MacroDefinition: q2m_c ( q , r ) ( q2m_c ( CONST_VEC ( q ) , ( r ) ) )
# Skipping MacroDefinition: qxq_c ( q1 , q2 , qout ) ( qxq_c ( CONST_VEC ( q1 ) , CONST_VEC ( q2 ) , ( qout ) ) )
# Skipping MacroDefinition: rav2xf_c ( rot , av , xform ) ( rav2xf_c ( CONST_MAT ( rot ) , CONST_VEC ( av ) , ( xform ) ) )
# Skipping MacroDefinition: raxisa_c ( matrix , axis , angle ) ( raxisa_c ( CONST_MAT ( matrix ) , ( axis ) , ( angle ) ) ) ;
# Skipping MacroDefinition: reccyl_c ( rectan , r , lon , z ) ( reccyl_c ( CONST_VEC ( rectan ) , ( r ) , ( lon ) , ( z ) ) )
# Skipping MacroDefinition: recgeo_c ( rectan , re , f , lon , lat , alt ) ( recgeo_c ( CONST_VEC ( rectan ) , ( re ) , ( f ) , ( lon ) , ( lat ) , ( alt ) ) )
# Skipping MacroDefinition: reclat_c ( rectan , r , lon , lat ) ( reclat_c ( CONST_VEC ( rectan ) , ( r ) , ( lon ) , ( lat ) ) )
# Skipping MacroDefinition: recrad_c ( rectan , radius , ra , dec ) ( recrad_c ( CONST_VEC ( rectan ) , ( radius ) , ( ra ) , ( dec ) ) )
# Skipping MacroDefinition: recsph_c ( rectan , r , colat , lon ) ( recsph_c ( CONST_VEC ( rectan ) , ( r ) , ( colat ) , ( lon ) ) )
# Skipping MacroDefinition: reordd_c ( iorder , ndim , array ) ( reordd_c ( CONST_IVEC ( iorder ) , ( ndim ) , ( array ) ) )
# Skipping MacroDefinition: reordi_c ( iorder , ndim , array ) ( reordi_c ( CONST_IVEC ( iorder ) , ( ndim ) , ( array ) ) )
# Skipping MacroDefinition: reordl_c ( iorder , ndim , array ) ( reordl_c ( CONST_IVEC ( iorder ) , ( ndim ) , ( array ) ) )
# Skipping MacroDefinition: rotmat_c ( m1 , angle , iaxis , mout ) ( rotmat_c ( CONST_MAT ( m1 ) , ( angle ) , ( iaxis ) , ( mout ) ) )
# Skipping MacroDefinition: rotvec_c ( v1 , angle , iaxis , vout ) ( rotvec_c ( CONST_VEC ( v1 ) , ( angle ) , ( iaxis ) , ( vout ) ) )
# Skipping MacroDefinition: saelgv_c ( vec1 , vec2 , smajor , sminor ) ( saelgv_c ( CONST_VEC ( vec1 ) , CONST_VEC ( vec2 ) , ( smajor ) , ( sminor ) ) )
# Skipping MacroDefinition: spk14a_c ( handle , ncsets , coeffs , epochs ) ( spk14a_c ( ( handle ) , ( ncsets ) , CONST_VEC ( coeffs ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkapo_c ( targ , et , ref , sobs , abcorr , ptarg , lt ) ( spkapo_c ( ( targ ) , ( et ) , ( ref ) , CONST_VEC ( sobs ) , ( abcorr ) , ( ptarg ) , ( lt ) ) )
# Skipping MacroDefinition: spkapp_c ( targ , et , ref , sobs , abcorr , starg , lt ) ( spkapp_c ( ( targ ) , ( et ) , ( ref ) , CONST_VEC ( sobs ) , ( abcorr ) , ( starg ) , ( lt ) ) )
# Skipping MacroDefinition: spkaps_c ( targ , et , ref , abcorr , sobs , accobs , starg , lt , dlt ) ( spkaps_c ( ( targ ) , ( et ) , ( ref ) , ( abcorr ) , CONST_VEC ( sobs ) , CONST_VEC ( accobs ) , ( starg ) , ( lt ) , ( dlt ) ) )
# Skipping MacroDefinition: spkcpo_c ( target , et , outref , refloc , abcorr , obspos , obsctr , obsref , state , lt ) ( spkcpo_c ( ( target ) , ( et ) , ( outref ) , ( refloc ) , ( abcorr ) , CONST_VEC ( obspos ) , ( obsctr ) , ( obsref ) , ( state ) , ( lt ) ) )
# Skipping MacroDefinition: spkcpt_c ( trgpos , trgctr , trgref , et , outref , refloc , abcorr , obsrvr , state , lt ) ( spkcpt_c ( CONST_VEC ( trgpos ) , ( trgctr ) , ( trgref ) , ( et ) , ( outref ) , ( refloc ) , ( abcorr ) , ( obsrvr ) , ( state ) , ( lt ) ) )
# Skipping MacroDefinition: spkcvo_c ( target , et , outref , refloc , abcorr , obssta , obsepc , obsctr , obsref , state , lt ) ( spkcvo_c ( ( target ) , ( et ) , ( outref ) , ( refloc ) , ( abcorr ) , CONST_VEC ( obssta ) , ( obsepc ) , ( obsctr ) , ( obsref ) , ( state ) , ( lt ) ) )
# Skipping MacroDefinition: spkcvt_c ( trgsta , trgepc , trgctr , trgref , et , outref , refloc , abcorr , obsrvr , state , lt ) ( spkcvt_c ( CONST_VEC ( trgsta ) , ( trgepc ) , ( trgctr ) , ( trgref ) , ( et ) , ( outref ) , ( refloc ) , ( abcorr ) , ( obsrvr ) , ( state ) , ( lt ) ) )
# Skipping MacroDefinition: spkltc_c ( targ , et , ref , abcorr , sobs , starg , lt , dlt ) ( spkltc_c ( ( targ ) , ( et ) , ( ref ) , ( abcorr ) , CONST_VEC ( sobs ) , ( starg ) , ( lt ) , ( dlt ) ) )
# Skipping MacroDefinition: spkpvn_c ( handle , descr , et , ref , state , center ) ( spkpvn_c ( ( handle ) , CONST_VEC ( descr ) , ( et ) , ( ref ) , ( state ) , ( center ) ) )
# Skipping MacroDefinition: spkuds_c ( descr , body , center , frame , type , first , last , begin , end ) ( spkuds_c ( CONST_VEC ( descr ) , ( body ) , ( center ) , ( frame ) , ( type ) , ( first ) , ( last ) , ( begin ) , ( end ) ) )
# Skipping MacroDefinition: spkw02_c ( handle , body , center , frame , first , last , segid , intlen , n , polydg , cdata , btime ) ( spkw02_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( intlen ) , ( n ) , ( polydg ) , CONST_VEC ( cdata ) , ( btime ) ) )
# Skipping MacroDefinition: spkw03_c ( handle , body , center , frame , first , last , segid , intlen , n , polydg , cdata , btime ) ( spkw03_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( intlen ) , ( n ) , ( polydg ) , CONST_VEC ( cdata ) , ( btime ) ) )
# Skipping MacroDefinition: spkw05_c ( handle , body , center , frame , first , last , segid , gm , n , states , epochs ) ( spkw05_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( gm ) , ( n ) , CONST_MAT6 ( states ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkw08_c ( handle , body , center , frame , first , last , segid , degree , n , states , epoch1 , step ) ( spkw08_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( degree ) , ( n ) , CONST_MAT6 ( states ) , ( epoch1 ) , ( step ) ) )
# Skipping MacroDefinition: spkw09_c ( handle , body , center , frame , first , last , segid , degree , n , states , epochs ) ( spkw09_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( degree ) , ( n ) , CONST_MAT6 ( states ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkw10_c ( handle , body , center , frame , first , last , segid , consts , n , elems , epochs ) ( spkw10_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , CONST_VEC ( consts ) , ( n ) , CONST_VEC ( elems ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkw12_c ( handle , body , center , frame , first , last , segid , degree , n , states , epoch0 , step ) ( spkw12_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( degree ) , ( n ) , CONST_MAT6 ( states ) , ( epoch0 ) , ( step ) ) )
# Skipping MacroDefinition: spkw13_c ( handle , body , center , frame , first , last , segid , degree , n , states , epochs ) ( spkw13_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( degree ) , ( n ) , CONST_MAT6 ( states ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkw15_c ( handle , body , center , frame , first , last , segid , epoch , tp , pa , p , ecc , j2flg , pv , gm , j2 , radius ) ( spkw15_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( epoch ) , CONST_VEC ( tp ) , CONST_VEC ( pa ) , ( p ) , ( ecc ) , ( j2flg ) , CONST_VEC ( pv ) , ( gm ) , ( j2 ) , ( radius ) ) )
# Skipping MacroDefinition: spkw17_c ( handle , body , center , frame , first , last , segid , epoch , eqel , rapol , decpol ) ( spkw17_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( epoch ) , CONST_VEC ( eqel ) , ( rapol ) , ( decpol ) ) )
# Skipping MacroDefinition: spkw18_c ( handle , subtyp , body , center , frame , first , last , segid , degree , n , packts , epochs ) ( spkw18_c ( ( handle ) , ( subtyp ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( degree ) , ( n ) , CONST_VOID ( packts ) , CONST_VEC ( epochs ) ) )
# Skipping MacroDefinition: spkw20_c ( handle , body , center , frame , first , last , segid , intlen , n , polydg , cdata , dscale , tscale , initjd , initfr ) ( spkw20_c ( ( handle ) , ( body ) , ( center ) , ( frame ) , ( first ) , ( last ) , ( segid ) , ( intlen ) , ( n ) , ( polydg ) , CONST_VEC ( cdata ) , ( dscale ) , ( tscale ) , ( initjd ) , ( initfr ) ) )
# Skipping MacroDefinition: srfxpt_c ( method , target , et , abcorr , obsrvr , dref , dvec , spoint , dist , trgepc , obspos , found ) ( srfxpt_c ( ( method ) , ( target ) , ( et ) , ( abcorr ) , ( obsrvr ) , ( dref ) , CONST_VEC ( dvec ) , ( spoint ) , ( dist ) , ( trgepc ) , ( obspos ) , ( found ) ) )
# Skipping MacroDefinition: stelab_c ( pobj , vobj , appobj ) ( stelab_c ( CONST_VEC ( pobj ) , CONST_VEC ( vobj ) , ( appobj ) ) )
# Skipping MacroDefinition: sumad_c ( array , n ) ( sumad_c ( CONST_VEC ( array ) , ( n ) ) )
# Skipping MacroDefinition: sumai_c ( array , n ) ( sumai_c ( CONST_IVEC ( array ) , ( n ) ) )
# Skipping MacroDefinition: surfnm_c ( a , b , c , point , normal ) ( surfnm_c ( ( a ) , ( b ) , ( c ) , CONST_VEC ( point ) , ( normal ) ) )
# Skipping MacroDefinition: surfpt_c ( positn , u , a , b , c , point , found ) ( surfpt_c ( CONST_VEC ( positn ) , CONST_VEC ( u ) , ( a ) , ( b ) , ( c ) , ( point ) , ( found ) ) )
# Skipping MacroDefinition: surfpv_c ( stvrtx , stdir , a , b , c , stx , found ) ( surfpv_c ( CONST_VEC ( stvrtx ) , CONST_VEC ( stdir ) , ( a ) , ( b ) , ( c ) , ( stx ) , ( found ) ) )
# Skipping MacroDefinition: swpool_c ( agent , nnames , lenvals , names ) ( swpool_c ( CONST_STR ( agent ) , ( nnames ) , ( lenvals ) , CONST_VOID ( names ) ) )
# Skipping MacroDefinition: trace_c ( m1 ) ( trace_c ( CONST_MAT ( m1 ) ) )
# Skipping MacroDefinition: twovec_c ( axdef , indexa , plndef , indexp , mout ) ( twovec_c ( CONST_VEC ( axdef ) , ( indexa ) , CONST_VEC ( plndef ) , ( indexp ) , ( mout ) ) )
# Skipping MacroDefinition: ucrss_c ( v1 , v2 , vout ) ( ucrss_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( vout ) ) )
# Skipping MacroDefinition: unorm_c ( v1 , vout , vmag ) ( unorm_c ( CONST_VEC ( v1 ) , ( vout ) , ( vmag ) ) )
# Skipping MacroDefinition: unormg_c ( v1 , ndim , vout , vmag ) ( unormg_c ( CONST_VEC ( v1 ) , ( ndim ) , ( vout ) , ( vmag ) ) )
# Skipping MacroDefinition: vadd_c ( v1 , v2 , vout ) ( vadd_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( vout ) ) )
# Skipping MacroDefinition: vaddg_c ( v1 , v2 , ndim , vout ) ( vaddg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vcrss_c ( v1 , v2 , vout ) ( vcrss_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( vout ) ) )
# Skipping MacroDefinition: vdist_c ( v1 , v2 ) ( vdist_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) ) )
# Skipping MacroDefinition: vdistg_c ( v1 , v2 , ndim ) ( vdistg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( ndim ) ) )
# Skipping MacroDefinition: vdot_c ( v1 , v2 ) ( vdot_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) ) )
# Skipping MacroDefinition: vdotg_c ( v1 , v2 , ndim ) ( vdotg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( ndim ) ) )
# Skipping MacroDefinition: vequ_c ( vin , vout ) ( vequ_c ( CONST_VEC ( vin ) , ( vout ) ) )
# Skipping MacroDefinition: vequg_c ( vin , ndim , vout ) ( vequg_c ( CONST_VEC ( vin ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vhat_c ( v1 , vout ) ( vhat_c ( CONST_VEC ( v1 ) , ( vout ) ) )
# Skipping MacroDefinition: vhatg_c ( v1 , ndim , vout ) ( vhatg_c ( CONST_VEC ( v1 ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vlcom3_c ( a , v1 , b , v2 , c , v3 , sum ) ( vlcom3_c ( ( a ) , CONST_VEC ( v1 ) , ( b ) , CONST_VEC ( v2 ) , ( c ) , CONST_VEC ( v3 ) , ( sum ) ) )
# Skipping MacroDefinition: vlcom_c ( a , v1 , b , v2 , sum ) ( vlcom_c ( ( a ) , CONST_VEC ( v1 ) , ( b ) , CONST_VEC ( v2 ) , ( sum ) ) )
# Skipping MacroDefinition: vlcomg_c ( n , a , v1 , b , v2 , sum ) ( vlcomg_c ( ( n ) , ( a ) , CONST_VEC ( v1 ) , ( b ) , CONST_VEC ( v2 ) , ( sum ) ) )
# Skipping MacroDefinition: vminug_c ( v1 , ndim , vout ) ( vminug_c ( CONST_VEC ( v1 ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vminus_c ( v1 , vout ) ( vminus_c ( CONST_VEC ( v1 ) , ( vout ) ) )
# Skipping MacroDefinition: vnorm_c ( v1 ) ( vnorm_c ( CONST_VEC ( v1 ) ) )
# Skipping MacroDefinition: vnormg_c ( v1 , ndim ) ( vnormg_c ( CONST_VEC ( v1 ) , ( ndim ) ) )
# Skipping MacroDefinition: vperp_c ( a , b , p ) ( vperp_c ( CONST_VEC ( a ) , CONST_VEC ( b ) , ( p ) ) )
# Skipping MacroDefinition: vprjp_c ( vin , plane , vout ) ( vprjp_c ( CONST_VEC ( vin ) , CONST_PLANE ( plane ) , ( vout ) ) )
# Skipping MacroDefinition: vprjpi_c ( vin , projpl , invpl , vout , found ) ( vprjpi_c ( CONST_VEC ( vin ) , CONST_PLANE ( projpl ) , CONST_PLANE ( invpl ) , ( vout ) , ( found ) ) )
# Skipping MacroDefinition: vproj_c ( a , b , p ) ( vproj_c ( CONST_VEC ( a ) , CONST_VEC ( b ) , ( p ) ) )
# Skipping MacroDefinition: vrel_c ( v1 , v2 ) ( vrel_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) ) )
# Skipping MacroDefinition: vrelg_c ( v1 , v2 , ndim ) ( vrelg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( ndim ) ) )
# Skipping MacroDefinition: vrotv_c ( v , axis , theta , r ) ( vrotv_c ( CONST_VEC ( v ) , CONST_VEC ( axis ) , ( theta ) , ( r ) ) )
# Skipping MacroDefinition: vscl_c ( s , v1 , vout ) ( vscl_c ( ( s ) , CONST_VEC ( v1 ) , ( vout ) ) )
# Skipping MacroDefinition: vsclg_c ( s , v1 , ndim , vout ) ( vsclg_c ( ( s ) , CONST_VEC ( v1 ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vsep_c ( v1 , v2 ) ( vsep_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) ) )
# Skipping MacroDefinition: vsepg_c ( v1 , v2 , ndim ) ( vsepg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ndim ) )
# Skipping MacroDefinition: vsub_c ( v1 , v2 , vout ) ( vsub_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( vout ) ) )
# Skipping MacroDefinition: vsubg_c ( v1 , v2 , ndim , vout ) ( vsubg_c ( CONST_VEC ( v1 ) , CONST_VEC ( v2 ) , ( ndim ) , ( vout ) ) )
# Skipping MacroDefinition: vtmv_c ( v1 , mat , v2 ) ( vtmv_c ( CONST_VEC ( v1 ) , CONST_MAT ( mat ) , CONST_VEC ( v2 ) ) )
# Skipping MacroDefinition: vtmvg_c ( v1 , mat , v2 , nrow , ncol ) ( vtmvg_c ( CONST_VOID ( v1 ) , CONST_VOID ( mat ) , CONST_VOID ( v2 ) , ( nrow ) , ( ncol ) ) )
# Skipping MacroDefinition: vupack_c ( v , x , y , z ) ( vupack_c ( CONST_VEC ( v ) , ( x ) , ( y ) , ( z ) ) )
# Skipping MacroDefinition: vzero_c ( v1 ) ( vzero_c ( CONST_VEC ( v1 ) ) )
# Skipping MacroDefinition: vzerog_c ( v1 , ndim ) ( vzerog_c ( CONST_VEC ( v1 ) , ( ndim ) ) )
# Skipping MacroDefinition: xf2eul_c ( xform , axisa , axisb , axisc , eulang , unique ) ( xf2eul_c ( CONST_MAT6 ( xform ) , ( axisa ) , ( axisb ) , ( axisc ) , ( eulang ) , ( unique ) ) )
# Skipping MacroDefinition: xf2rav_c ( xform , rot , av ) ( xf2rav_c ( CONST_MAT6 ( xform ) , ( rot ) , ( av ) ) )
# Skipping MacroDefinition: xpose6_c ( m1 , mout ) ( xpose6_c ( CONST_MAT6 ( m1 ) , ( mout ) ) )
# Skipping MacroDefinition: xpose_c ( m1 , mout ) ( xpose_c ( CONST_MAT ( m1 ) , ( mout ) ) )
# Skipping MacroDefinition: xposeg_c ( matrix , nrow , ncol , mout ) ( xposeg_c ( CONST_VOID ( matrix ) , ( nrow ) , ( ncol ) , ( mout ) ) )

typealias __int128_t Int128
typealias __UInt128_t UInt128

## immutable Array_1___va_list_tag
    ## d1::__va_list_tag
## end
## 
## zero(::Type{Array_1___va_list_tag}) = Array_1___va_list_tag(fill(zero(__va_list_tag),1)...)
## 
## typealias __builtin_va_list Array_1___va_list_tag
typealias SpiceChar UInt8
typealias SpiceDouble Cdouble
typealias SpiceFloat Cfloat
typealias SpiceInt Clong
typealias ConstSpiceChar UInt8
typealias ConstSpiceDouble Cdouble
typealias ConstSpiceFloat Cfloat
typealias ConstSpiceInt Clong
typealias SpiceLong Clong
typealias SpiceShort Int16
typealias SpiceUChar Cuchar
typealias SpiceUInt UInt32
typealias SpiceULong Culong
typealias SpiceUShort UInt16
typealias SpiceSChar UInt8
typealias SpiceBoolean Cint
typealias ConstSpiceBoolean Cint

# begin enum _Spicestatus
typealias _Spicestatus Cint
const SPICEFAILURE = (Int32)(-1)
const SPICESUCCESS = (Int32)(0)
# end enum _Spicestatus

typealias SpiceStatus _Spicestatus

# begin enum _SpiceDataType
typealias _SpiceDataType UInt32
const SPICE_CHR = (UInt32)(0)
const SPICE_DP = (UInt32)(1)
const SPICE_INT = (UInt32)(2)
const SPICE_TIME = (UInt32)(3)
const SPICE_BOOL = (UInt32)(4)
# end enum _SpiceDataType

typealias SpiceDataType _SpiceDataType
typealias SpiceEKDataType SpiceDataType

# begin enum _SpiceEKExprClass
typealias _SpiceEKExprClass UInt32
const SPICE_EK_EXP_COL = (UInt32)(0)
const SPICE_EK_EXP_FUNC = (UInt32)(1)
const SPICE_EK_EXP_EXPR = (UInt32)(2)
# end enum _SpiceEKExprClass

typealias SpiceEKExprClass _SpiceEKExprClass

type _SpiceEKAttDsc
    cclass::SpiceInt
    dtype::SpiceEKDataType
    strlen::SpiceInt
    size::SpiceInt
    indexd::SpiceBoolean
    nullok::SpiceBoolean
end

typealias SpiceEKAttDsc _SpiceEKAttDsc

immutable Array_65_SpiceChar
    d1::SpiceChar
    d2::SpiceChar
    d3::SpiceChar
    d4::SpiceChar
    d5::SpiceChar
    d6::SpiceChar
    d7::SpiceChar
    d8::SpiceChar
    d9::SpiceChar
    d10::SpiceChar
    d11::SpiceChar
    d12::SpiceChar
    d13::SpiceChar
    d14::SpiceChar
    d15::SpiceChar
    d16::SpiceChar
    d17::SpiceChar
    d18::SpiceChar
    d19::SpiceChar
    d20::SpiceChar
    d21::SpiceChar
    d22::SpiceChar
    d23::SpiceChar
    d24::SpiceChar
    d25::SpiceChar
    d26::SpiceChar
    d27::SpiceChar
    d28::SpiceChar
    d29::SpiceChar
    d30::SpiceChar
    d31::SpiceChar
    d32::SpiceChar
    d33::SpiceChar
    d34::SpiceChar
    d35::SpiceChar
    d36::SpiceChar
    d37::SpiceChar
    d38::SpiceChar
    d39::SpiceChar
    d40::SpiceChar
    d41::SpiceChar
    d42::SpiceChar
    d43::SpiceChar
    d44::SpiceChar
    d45::SpiceChar
    d46::SpiceChar
    d47::SpiceChar
    d48::SpiceChar
    d49::SpiceChar
    d50::SpiceChar
    d51::SpiceChar
    d52::SpiceChar
    d53::SpiceChar
    d54::SpiceChar
    d55::SpiceChar
    d56::SpiceChar
    d57::SpiceChar
    d58::SpiceChar
    d59::SpiceChar
    d60::SpiceChar
    d61::SpiceChar
    d62::SpiceChar
    d63::SpiceChar
    d64::SpiceChar
    d65::SpiceChar
end

zero(::Type{Array_65_SpiceChar}) = Array_65_SpiceChar(fill(zero(SpiceChar),65)...)

immutable Array_33_SpiceChar
    d1::SpiceChar
    d2::SpiceChar
    d3::SpiceChar
    d4::SpiceChar
    d5::SpiceChar
    d6::SpiceChar
    d7::SpiceChar
    d8::SpiceChar
    d9::SpiceChar
    d10::SpiceChar
    d11::SpiceChar
    d12::SpiceChar
    d13::SpiceChar
    d14::SpiceChar
    d15::SpiceChar
    d16::SpiceChar
    d17::SpiceChar
    d18::SpiceChar
    d19::SpiceChar
    d20::SpiceChar
    d21::SpiceChar
    d22::SpiceChar
    d23::SpiceChar
    d24::SpiceChar
    d25::SpiceChar
    d26::SpiceChar
    d27::SpiceChar
    d28::SpiceChar
    d29::SpiceChar
    d30::SpiceChar
    d31::SpiceChar
    d32::SpiceChar
    d33::SpiceChar
end

zero(::Type{Array_33_SpiceChar}) = Array_33_SpiceChar(fill(zero(SpiceChar),33)...)

immutable Array_100_Array_33_SpiceChar
    d1::Array_33_SpiceChar
    d2::Array_33_SpiceChar
    d3::Array_33_SpiceChar
    d4::Array_33_SpiceChar
    d5::Array_33_SpiceChar
    d6::Array_33_SpiceChar
    d7::Array_33_SpiceChar
    d8::Array_33_SpiceChar
    d9::Array_33_SpiceChar
    d10::Array_33_SpiceChar
    d11::Array_33_SpiceChar
    d12::Array_33_SpiceChar
    d13::Array_33_SpiceChar
    d14::Array_33_SpiceChar
    d15::Array_33_SpiceChar
    d16::Array_33_SpiceChar
    d17::Array_33_SpiceChar
    d18::Array_33_SpiceChar
    d19::Array_33_SpiceChar
    d20::Array_33_SpiceChar
    d21::Array_33_SpiceChar
    d22::Array_33_SpiceChar
    d23::Array_33_SpiceChar
    d24::Array_33_SpiceChar
    d25::Array_33_SpiceChar
    d26::Array_33_SpiceChar
    d27::Array_33_SpiceChar
    d28::Array_33_SpiceChar
    d29::Array_33_SpiceChar
    d30::Array_33_SpiceChar
    d31::Array_33_SpiceChar
    d32::Array_33_SpiceChar
    d33::Array_33_SpiceChar
    d34::Array_33_SpiceChar
    d35::Array_33_SpiceChar
    d36::Array_33_SpiceChar
    d37::Array_33_SpiceChar
    d38::Array_33_SpiceChar
    d39::Array_33_SpiceChar
    d40::Array_33_SpiceChar
    d41::Array_33_SpiceChar
    d42::Array_33_SpiceChar
    d43::Array_33_SpiceChar
    d44::Array_33_SpiceChar
    d45::Array_33_SpiceChar
    d46::Array_33_SpiceChar
    d47::Array_33_SpiceChar
    d48::Array_33_SpiceChar
    d49::Array_33_SpiceChar
    d50::Array_33_SpiceChar
    d51::Array_33_SpiceChar
    d52::Array_33_SpiceChar
    d53::Array_33_SpiceChar
    d54::Array_33_SpiceChar
    d55::Array_33_SpiceChar
    d56::Array_33_SpiceChar
    d57::Array_33_SpiceChar
    d58::Array_33_SpiceChar
    d59::Array_33_SpiceChar
    d60::Array_33_SpiceChar
    d61::Array_33_SpiceChar
    d62::Array_33_SpiceChar
    d63::Array_33_SpiceChar
    d64::Array_33_SpiceChar
    d65::Array_33_SpiceChar
    d66::Array_33_SpiceChar
    d67::Array_33_SpiceChar
    d68::Array_33_SpiceChar
    d69::Array_33_SpiceChar
    d70::Array_33_SpiceChar
    d71::Array_33_SpiceChar
    d72::Array_33_SpiceChar
    d73::Array_33_SpiceChar
    d74::Array_33_SpiceChar
    d75::Array_33_SpiceChar
    d76::Array_33_SpiceChar
    d77::Array_33_SpiceChar
    d78::Array_33_SpiceChar
    d79::Array_33_SpiceChar
    d80::Array_33_SpiceChar
    d81::Array_33_SpiceChar
    d82::Array_33_SpiceChar
    d83::Array_33_SpiceChar
    d84::Array_33_SpiceChar
    d85::Array_33_SpiceChar
    d86::Array_33_SpiceChar
    d87::Array_33_SpiceChar
    d88::Array_33_SpiceChar
    d89::Array_33_SpiceChar
    d90::Array_33_SpiceChar
    d91::Array_33_SpiceChar
    d92::Array_33_SpiceChar
    d93::Array_33_SpiceChar
    d94::Array_33_SpiceChar
    d95::Array_33_SpiceChar
    d96::Array_33_SpiceChar
    d97::Array_33_SpiceChar
    d98::Array_33_SpiceChar
    d99::Array_33_SpiceChar
    d100::Array_33_SpiceChar
end

zero(::Type{Array_100_Array_33_SpiceChar}) = Array_100_Array_33_SpiceChar(fill(zero(Array_33_SpiceChar),100)...)

immutable Array_100_SpiceEKAttDsc
    d1::SpiceEKAttDsc
    d2::SpiceEKAttDsc
    d3::SpiceEKAttDsc
    d4::SpiceEKAttDsc
    d5::SpiceEKAttDsc
    d6::SpiceEKAttDsc
    d7::SpiceEKAttDsc
    d8::SpiceEKAttDsc
    d9::SpiceEKAttDsc
    d10::SpiceEKAttDsc
    d11::SpiceEKAttDsc
    d12::SpiceEKAttDsc
    d13::SpiceEKAttDsc
    d14::SpiceEKAttDsc
    d15::SpiceEKAttDsc
    d16::SpiceEKAttDsc
    d17::SpiceEKAttDsc
    d18::SpiceEKAttDsc
    d19::SpiceEKAttDsc
    d20::SpiceEKAttDsc
    d21::SpiceEKAttDsc
    d22::SpiceEKAttDsc
    d23::SpiceEKAttDsc
    d24::SpiceEKAttDsc
    d25::SpiceEKAttDsc
    d26::SpiceEKAttDsc
    d27::SpiceEKAttDsc
    d28::SpiceEKAttDsc
    d29::SpiceEKAttDsc
    d30::SpiceEKAttDsc
    d31::SpiceEKAttDsc
    d32::SpiceEKAttDsc
    d33::SpiceEKAttDsc
    d34::SpiceEKAttDsc
    d35::SpiceEKAttDsc
    d36::SpiceEKAttDsc
    d37::SpiceEKAttDsc
    d38::SpiceEKAttDsc
    d39::SpiceEKAttDsc
    d40::SpiceEKAttDsc
    d41::SpiceEKAttDsc
    d42::SpiceEKAttDsc
    d43::SpiceEKAttDsc
    d44::SpiceEKAttDsc
    d45::SpiceEKAttDsc
    d46::SpiceEKAttDsc
    d47::SpiceEKAttDsc
    d48::SpiceEKAttDsc
    d49::SpiceEKAttDsc
    d50::SpiceEKAttDsc
    d51::SpiceEKAttDsc
    d52::SpiceEKAttDsc
    d53::SpiceEKAttDsc
    d54::SpiceEKAttDsc
    d55::SpiceEKAttDsc
    d56::SpiceEKAttDsc
    d57::SpiceEKAttDsc
    d58::SpiceEKAttDsc
    d59::SpiceEKAttDsc
    d60::SpiceEKAttDsc
    d61::SpiceEKAttDsc
    d62::SpiceEKAttDsc
    d63::SpiceEKAttDsc
    d64::SpiceEKAttDsc
    d65::SpiceEKAttDsc
    d66::SpiceEKAttDsc
    d67::SpiceEKAttDsc
    d68::SpiceEKAttDsc
    d69::SpiceEKAttDsc
    d70::SpiceEKAttDsc
    d71::SpiceEKAttDsc
    d72::SpiceEKAttDsc
    d73::SpiceEKAttDsc
    d74::SpiceEKAttDsc
    d75::SpiceEKAttDsc
    d76::SpiceEKAttDsc
    d77::SpiceEKAttDsc
    d78::SpiceEKAttDsc
    d79::SpiceEKAttDsc
    d80::SpiceEKAttDsc
    d81::SpiceEKAttDsc
    d82::SpiceEKAttDsc
    d83::SpiceEKAttDsc
    d84::SpiceEKAttDsc
    d85::SpiceEKAttDsc
    d86::SpiceEKAttDsc
    d87::SpiceEKAttDsc
    d88::SpiceEKAttDsc
    d89::SpiceEKAttDsc
    d90::SpiceEKAttDsc
    d91::SpiceEKAttDsc
    d92::SpiceEKAttDsc
    d93::SpiceEKAttDsc
    d94::SpiceEKAttDsc
    d95::SpiceEKAttDsc
    d96::SpiceEKAttDsc
    d97::SpiceEKAttDsc
    d98::SpiceEKAttDsc
    d99::SpiceEKAttDsc
    d100::SpiceEKAttDsc
end

zero(::Type{Array_100_SpiceEKAttDsc}) = Array_100_SpiceEKAttDsc(fill(zero(SpiceEKAttDsc),100)...)

type _SpiceEKSegSum
    tabnam::Array_65_SpiceChar
    nrows::SpiceInt
    ncols::SpiceInt
    cnames::Array_100_Array_33_SpiceChar
    cdescrs::Array_100_SpiceEKAttDsc
end

typealias SpiceEKSegSum _SpiceEKSegSum
typealias SpiceCellDataType _SpiceDataType

type _SpiceCell
    dtype::SpiceCellDataType
    length::SpiceInt
    size::SpiceInt
    card::SpiceInt
    isSet::SpiceBoolean
    adjust::SpiceBoolean
    init::SpiceBoolean
    base::Ptr{Void}
    data::Ptr{Void}
end

typealias SpiceCell _SpiceCell
typealias ConstSpiceCell SpiceCell

# begin enum _SpiceTransDir
typealias _SpiceTransDir UInt32
const C2F = (UInt32)(0)
const F2C = (UInt32)(1)
# end enum _SpiceTransDir

typealias SpiceTransDir _SpiceTransDir

# begin enum _SpiceCK05Subtype
typealias _SpiceCK05Subtype UInt32
const C05TP0 = (UInt32)(0)
const C05TP1 = (UInt32)(1)
const C05TP2 = (UInt32)(2)
const C05TP3 = (UInt32)(3)
# end enum _SpiceCK05Subtype

typealias SpiceCK05Subtype _SpiceCK05Subtype

# begin enum _SpiceSPK18Subtype
typealias _SpiceSPK18Subtype UInt32
const S18TP0 = (UInt32)(0)
const S18TP1 = (UInt32)(1)
# end enum _SpiceSPK18Subtype

typealias SpiceSPK18Subtype _SpiceSPK18Subtype

immutable Array_3_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
    d3::SpiceDouble
end

zero(::Type{Array_3_SpiceDouble}) = Array_3_SpiceDouble(fill(zero(SpiceDouble),3)...)

type _SpicePlane
    normal::Array_3_SpiceDouble
    constant::SpiceDouble
end

typealias SpicePlane _SpicePlane
typealias ConstSpicePlane SpicePlane

type _SpiceEllipse
    center::Array_3_SpiceDouble
    semiMajor::Array_3_SpiceDouble
    semiMinor::Array_3_SpiceDouble
end

typealias SpiceEllipse _SpiceEllipse
typealias ConstSpiceEllipse SpiceEllipse

immutable Array_3_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
end

zero(::Type{Array_3_ConstSpiceDouble}) = Array_3_ConstSpiceDouble(fill(zero(ConstSpiceDouble),3)...)

immutable Array_3_Array_3_SpiceDouble
    d1::Array_3_SpiceDouble
    d2::Array_3_SpiceDouble
    d3::Array_3_SpiceDouble
end

zero(::Type{Array_3_Array_3_SpiceDouble}) = Array_3_Array_3_SpiceDouble(fill(zero(Array_3_SpiceDouble),3)...)

immutable Array_4_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
    d4::ConstSpiceDouble
end

zero(::Type{Array_4_ConstSpiceDouble}) = Array_4_ConstSpiceDouble(fill(zero(ConstSpiceDouble),4)...)

immutable Array_8_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
    d4::ConstSpiceDouble
    d5::ConstSpiceDouble
    d6::ConstSpiceDouble
    d7::ConstSpiceDouble
    d8::ConstSpiceDouble
end

zero(::Type{Array_8_ConstSpiceDouble}) = Array_8_ConstSpiceDouble(fill(zero(ConstSpiceDouble),8)...)

immutable Array_6_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
    d3::SpiceDouble
    d4::SpiceDouble
    d5::SpiceDouble
    d6::SpiceDouble
end

zero(::Type{Array_6_SpiceDouble}) = Array_6_SpiceDouble(fill(zero(SpiceDouble),6)...)

immutable Array_3_Array_3_ConstSpiceDouble
    d1::Array_3_ConstSpiceDouble
    d2::Array_3_ConstSpiceDouble
    d3::Array_3_ConstSpiceDouble
end

zero(::Type{Array_3_Array_3_ConstSpiceDouble}) = Array_3_Array_3_ConstSpiceDouble(fill(zero(Array_3_ConstSpiceDouble),3)...)

immutable Array_2_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
end

zero(::Type{Array_2_ConstSpiceDouble}) = Array_2_ConstSpiceDouble(fill(zero(ConstSpiceDouble),2)...)

immutable Array_2_Array_2_ConstSpiceDouble
    d1::Array_2_ConstSpiceDouble
    d2::Array_2_ConstSpiceDouble
end

zero(::Type{Array_2_Array_2_ConstSpiceDouble}) = Array_2_Array_2_ConstSpiceDouble(fill(zero(Array_2_ConstSpiceDouble),2)...)

immutable Array_2_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
end

zero(::Type{Array_2_SpiceDouble}) = Array_2_SpiceDouble(fill(zero(SpiceDouble),2)...)

immutable Array_2_Array_2_SpiceDouble
    d1::Array_2_SpiceDouble
    d2::Array_2_SpiceDouble
end

zero(::Type{Array_2_Array_2_SpiceDouble}) = Array_2_Array_2_SpiceDouble(fill(zero(Array_2_SpiceDouble),2)...)

immutable Array_1_SpiceChar
    d1::SpiceChar
end

zero(::Type{Array_1_SpiceChar}) = Array_1_SpiceChar(fill(zero(SpiceChar),1)...)

immutable Array_6_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
    d4::ConstSpiceDouble
    d5::ConstSpiceDouble
    d6::ConstSpiceDouble
end

zero(::Type{Array_6_ConstSpiceDouble}) = Array_6_ConstSpiceDouble(fill(zero(ConstSpiceDouble),6)...)

immutable Array_9_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
    d4::ConstSpiceDouble
    d5::ConstSpiceDouble
    d6::ConstSpiceDouble
    d7::ConstSpiceDouble
    d8::ConstSpiceDouble
    d9::ConstSpiceDouble
end

zero(::Type{Array_9_ConstSpiceDouble}) = Array_9_ConstSpiceDouble(fill(zero(ConstSpiceDouble),9)...)

immutable Array_6_Array_6_SpiceDouble
    d1::Array_6_SpiceDouble
    d2::Array_6_SpiceDouble
    d3::Array_6_SpiceDouble
    d4::Array_6_SpiceDouble
    d5::Array_6_SpiceDouble
    d6::Array_6_SpiceDouble
end

zero(::Type{Array_6_Array_6_SpiceDouble}) = Array_6_Array_6_SpiceDouble(fill(zero(Array_6_SpiceDouble),6)...)

immutable Array_4_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
    d3::SpiceDouble
    d4::SpiceDouble
end

zero(::Type{Array_4_SpiceDouble}) = Array_4_SpiceDouble(fill(zero(SpiceDouble),4)...)

immutable Array_8_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
    d3::SpiceDouble
    d4::SpiceDouble
    d5::SpiceDouble
    d6::SpiceDouble
    d7::SpiceDouble
    d8::SpiceDouble
end

zero(::Type{Array_8_SpiceDouble}) = Array_8_SpiceDouble(fill(zero(SpiceDouble),8)...)

immutable Array_5_SpiceDouble
    d1::SpiceDouble
    d2::SpiceDouble
    d3::SpiceDouble
    d4::SpiceDouble
    d5::SpiceDouble
end

zero(::Type{Array_5_SpiceDouble}) = Array_5_SpiceDouble(fill(zero(SpiceDouble),5)...)

immutable Array_5_ConstSpiceDouble
    d1::ConstSpiceDouble
    d2::ConstSpiceDouble
    d3::ConstSpiceDouble
    d4::ConstSpiceDouble
    d5::ConstSpiceDouble
end

zero(::Type{Array_5_ConstSpiceDouble}) = Array_5_ConstSpiceDouble(fill(zero(ConstSpiceDouble),5)...)

immutable Array_6_Array_6_ConstSpiceDouble
    d1::Array_6_ConstSpiceDouble
    d2::Array_6_ConstSpiceDouble
    d3::Array_6_ConstSpiceDouble
    d4::Array_6_ConstSpiceDouble
    d5::Array_6_ConstSpiceDouble
    d6::Array_6_ConstSpiceDouble
end

zero(::Type{Array_6_Array_6_ConstSpiceDouble}) = Array_6_Array_6_ConstSpiceDouble(fill(zero(Array_6_ConstSpiceDouble),6)...)
