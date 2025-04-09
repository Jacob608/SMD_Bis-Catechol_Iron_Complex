# Prepare psfgen package for new psf generation.
package require psfgen
resetpsf

# Load the appropriate topology file.
topology charmm2lammps_all36_tip3/top_all36_prot_C2L.rtf

# Add the first tyrosine residue.
segment P1 { pdb tyr_1.pdb }
coordpdb tyr_1.pdb P1
guesscoord

# Add the second tyrosine residue.
segment P2 { pdb tyr_2.pdb }
coordpdb tyr_2.pdb P2
guesscoord

# Patch the two residues together.
patch DITY P1:70 P2:17

# Write a new pdb and psf file of this structure.
writepdb covalent_complex_noTER.pdb
writepsf covalent_complex.psf

exit
