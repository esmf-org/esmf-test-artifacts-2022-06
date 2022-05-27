Fri May 27 00:57:11 MDT 2022
#!/bin/sh -l
#PBS -N test-nag_6.2_mvapich2_O.bat
#PBS -l walltime=1:00:00
#PBS -q medium
#PBS -A P93300606
#PBS -l select=1:ncpus=48:mpiprocs=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/sacks/esmf-testing/nag_6.2_mvapich2_O_develop
module load compiler/nag/6.2-8.1.0 mpi/2.3.3/nag/6.2 tool/netcdf/c4.6.1-f4.4.4/nag-gnu/6.2-8.1.0
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/sacks/esmf-testing/nag_6.2_mvapich2_O_develop
export ESMF_COMPILER=nag
export ESMF_COMM=mvapich2
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

