Sat Jun 4 02:20:01 MDT 2022
#!/bin/sh -l
#PBS -N build-gfortran_7.4.0_openmpi_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=2:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/gfortran_7.4.0_openmpi_O_release_8.3.0

module load cmake
module load gnu/7.4.0 openmpi/4.0.3 netcdf/4.7.3
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_F90COMPILER=mpif90
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/gfortran_7.4.0_openmpi_O_release_8.3.0
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

