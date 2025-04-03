solvate=true

# Run a tcl script in VMD to generate a PDB and PSF file using Visual Molecular Dynamics.
module load vmd
vmd -dispdev text -e make_bis_catechol_iron_crosslink_psf.tcl > make_bis_catechol_iron_crosslink_psf.log

# If this simulation should be solvaetd, execute the following commands.
if $solvate; then
	vmd -dispdev text -e solvate_ionize.tcl > solvate_ionize.log
	# Rename the output to match the rest of the simulation workflow.
	mv ionized.pdb bis_catechol_iron_complex_noTER.pdb
	mv ionized.psf bis_catechol_iron_complex.psf
fi

# Run a bash script to create a LAMMPS data file from the PSF.
bash run_c2l.sh > run_c2l.log