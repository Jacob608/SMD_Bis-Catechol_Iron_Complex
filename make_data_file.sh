# Run a tcl script in VMD to generate a PDB and PSF file using Visual Molecular Dynamics.
module load vmd
vmd -dispdev text -e make_bis_catechol_iron_crosslink_psf.tcl > make_bis_catechol_iron_crosslink_psf.log

# Run a bash script to create a LAMMPS data file from the PSF.
bash run_c2l.sh > run_c2l.log