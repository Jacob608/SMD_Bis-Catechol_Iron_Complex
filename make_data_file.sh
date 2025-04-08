# Specify whether this simulation should be solvated or not.
solvate=true

# Run a tcl script in VMD to generate a PDB and PSF file using Visual Molecular Dynamics.
module load vmd
vmd -dispdev text -e make_bis_catechol_iron_crosslink_psf.tcl > make_bis_catechol_iron_crosslink_psf.log

# If this simulation should be solvaetd, execute the following commands.
if $solvate; then
	# Run the vmd compatible tcl script that adds solvent and ions.
	vmd -dispdev text -e solvate_ionize.tcl > solvate_ionize.log
	# Rename the output to match the rest of the simulation workflow.
	mv ionized.pdb bis_catechol_iron_complex_noTER.pdb
	mv ionized.psf bis_catechol_iron_complex.psf
fi

# Run a bash script to create a LAMMPS data file from the PSF.
bash run_c2l.sh > run_c2l.log

# Organize log and output files into a simulation directory.
cp -r smd_simulation_template smd_simulation

# Make a directory to store log files generated during the simulation creation.
mkdir smd_simulation/temp_files

# Move pdb, psf, and data files into the smd_simulation directory.
cp charmm2lammps_all36_tip3/bis_catechol_iron_complex.p* charmm2lammps_all36_tip3/bis_catechol_iron_complex.data smd_simulation

# Move llog files into teh temp_files directory.
mv run_c2l.log solvate_ionize.log make_bis_catechol_iron_crosslink_psf.log smd_simulation/temp_files

# Make a copy of the charm2lammps_all36_tip3 diretory in the newly created smd_simulation folder.
cp -r charmm2lammps_all36_tip3 smd_simulation/

# Clean up the files in the charmm2lammps_all36_tip3 folder.
cd charmm2lammps_all36_tip3
rm bis_catechol_iron* charmm2lammps.log
