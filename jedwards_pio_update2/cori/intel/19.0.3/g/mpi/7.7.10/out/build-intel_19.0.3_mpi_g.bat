Wed Mar 16 06:10:30 PDT 2022
#!/bin/sh -l
#SBATCH --account=e3sm
#SBATCH -o build-intel_19.0.3_mpi_g.bat_%j.o
#SBATCH -e build-intel_19.0.3_mpi_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH -C haswell
#SBATCH --qos=regular
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load intel/19.0.3.199 cray-mpich/7.7.10 cray-netcdf/4.6.3.2
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF_LIBS="-lnetcdf"
export ESMF_NETCDFF_LIBS="-lnetcdff"
export ESMF_DIR=/global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.0.3_mpi_g_jedwards_pio_update2
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 32 2>&1| tee build_$JOBID.log

