Tue Mar 29 06:02:51 MDT 2022
#!/bin/sh -l
#PBS -N test-intel_18.0.5_module_g.bat
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/rlong/esmf-testing/intel_18.0.5_module_g_jedwards_pio_update2

module load python
module load intel/18.0.5  netcdf/4.6.3
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/rlong/esmf-testing/intel_18.0.5_module_g_jedwards_pio_update2
export ESMF_COMPILER=intel
export ESMF_COMM=module
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

