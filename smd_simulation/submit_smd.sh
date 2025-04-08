#!/bin/bash
#SBATCH --job-name="smd_bis-catechol_complex"
#SBATCH -A p31412
#SBATCH -p short   ## partition
#SBATCH -n 8  ## number of cores
#SBATCH --output=R-%x.%j.out
#SBATCH --constraint="[quest10|quest11|quest12]"
#SBATCH -t 00:10:00

# Load necessary modules: lammps and python.
module purge all
module load lammps/20200303-openmpi-4.0.5-intel-19.0.5.281
module load python/anaconda3

# Activate the mdanalysis conda environment for calculate_xyz_for_fix_smd.py
source activate /home/jjg9482/anaconda3/envs/mdanalysis

# Run calculate_xyz_for_fix_smd.py to get xyz.txt.
python calculate_xyz_for_fix_smd.py -idx1 9 -idx2 32 -f 'equilibrated.data' > calculate_xyz_for_fix_smd.log

#### Copy the one line in xyz.txt into smd.in
# Make a copy of smd_template.in as smd.in 
cp smd_template.in smd.in

# Read the contents of the file xyz.txt output by calculate_xyz_for_fix_smd.py into a variable.
xyz=$(cat xyz.txt)

# Use sed to add the coordinates of the vector specifying pulling direction into smd.in.
string_to_replace="<x y z>"
sed -i "s/${string_to_replace}/${xyz}/g" smd.in

# Run a lammps script that performs a steered molecular dynamics simulation.
mpirun -np 8 lmp -in smd.in -log smd.log