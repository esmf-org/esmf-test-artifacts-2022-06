Sun May 22 16:38:55 MDT 2022
#!/bin/bash -l
export JOBID=12345

module use /project/esmf/stack/modulefiles/compilers
module load gcc/11.2.0  netcdf/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_MPILAUNCHOPTIONS=--oversubscribe
export ESMF_DIR=/Volumes/esmf/esmf-testing/gfortran_11.2.0_mpiuni_g_release_8.3.0
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 2>&1| tee build_$JOBID.log

