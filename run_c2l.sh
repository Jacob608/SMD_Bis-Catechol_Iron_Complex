#!/bin/bash

module load python/anaconda3

project='bis_catechol_iron_complex'
cd charmm2lammps_all36_tip3
mv ../bis_catechol_iron_complex* .

# Add TER line after each segment, ions, and water in the pdb file in preparation for charmm2lammps.pl script.
python addTER.py -i ${project}_noTER.pdb -o ${project}.pdb

# Run the charmm2lammps.pl script to get a lammps data file.
perl charmm2lammps.pl -cmap=36 all36_prot_C2L ${project} > charmm2lammps.log