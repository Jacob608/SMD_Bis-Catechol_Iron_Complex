# Prepare psfgen package for new psf generation.
package require psfgen
resetpsf

# Load the appropriate topology file.
topology charmm2lammps_all36_tip3/top_all36_prot_C2L_updated_charges.rtf

# Add the first divalent dopa.
segment P1 { pdb DO2E_1.pdb }
coordpdb DO2E_1.pdb P1
guesscoord

# Add the second divalent dopa.
segment P2 { pdb DO2E_2.pdb }
coordpdb DO2E_2.pdb P2
guesscoord

# Add the iron atom.
segment I { pdb fe3p.pdb }
coordpdb fe3p.pdb
guesscoord

# Regenerate angles and dihedrals
regenerate angles dihedrals

# Write a new pdb and psf file of this structure.
writepdb bis_catechol_iron_complex_noTER.pdb
writepsf bis_catechol_iron_complex.psf

exit
