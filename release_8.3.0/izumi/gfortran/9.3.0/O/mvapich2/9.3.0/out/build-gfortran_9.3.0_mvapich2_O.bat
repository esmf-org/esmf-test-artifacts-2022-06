Fri May 27 00:57:00 MDT 2022
#!/bin/sh -l
#PBS -N build-gfortran_9.3.0_mvapich2_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=1:00:00
#PBS -q medium
#PBS -A P93300606
#PBS -l select=1:ncpus=48:mpiprocs=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/sacks/esmf-testing/gfortran_9.3.0_mvapich2_O_release_8.3.0
module load compiler/gnu/9.3.0 mpi/2.3.3/gnu/9.3.0 tool/netcdf/4.7.4/gnu/9.3.0
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/sacks/esmf-testing/gfortran_9.3.0_mvapich2_O_release_8.3.0
export ESMF_COMPILER=gfortran
export ESMF_COMM=mvapich2
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 48 2>&1| tee build_$JOBID.log

