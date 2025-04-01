#!/bin/bash

module load python/anaconda3

project='bis_catechol_iron_complex'
cd charmm2lammps_all36_tip3
mv ../bis_catechol_iron_complex* .
python addTER.py -i ${project}_noTER.pdb -o ${project}.pdb

perl charmm2lammps.pl -cmap=36 all36_prot_C2L ${project} > charmm2lammps.log