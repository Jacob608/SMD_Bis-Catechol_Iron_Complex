#!/bin/bash
#SBATCH --job-name="equil_bis-catechol_complex"
#SBATCH -A p31412
#SBATCH -p short   ## partition
#SBATCH -n 4  ## number of cores
#SBATCH --output=R-%x.%j.out
#SBATCH --constraint="[quest10|quest11|quest12]"
#SBATCH -t 00:10:00

## cd $PBS_O_WORKDIR
module purge all
module load lammps/20200303-openmpi-4.0.5-intel-19.0.5.281

# Run a lammps simulation that equilibrates the system.
mpirun -np 4 lmp -in equil.in -log equil.log