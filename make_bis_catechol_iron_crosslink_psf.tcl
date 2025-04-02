# Prepare psfgen package for new psf generation.
package require psfgen
resetpsf

# Load the appropriate topology file.
topology charmm2lammps_all36_tip3/top_all36_prot_C2L.rtf

# Add the first divalent dopa.
segment P1 { pdb do2p_1.pdb }
coordpdb do2p_1.pdb P1
# For some reason the commands below only neutralized the carboxyl group and not the amine.
# patch CNEU P1:28
# patch NNEU P1:28
guesscoord

# Add the second divalent dopa.
segment P2 { pdb do2p_2.pdb }
coordpdb do2p_2.pdb P2
# For some reason the commands below only neutralized the carboxyl group and not the amine.
# patch CNEU P2:67
# patch NNEU P2:67
guesscoord

# Add the iron atom.
segment I { pdb fe3p.pdb }
coordpdb fe3p.pdb
guesscoord

# Write a new pdb and psf file of this structure.
writepdb bis_catechol_iron_complex_noTER.pdb
writepsf bis_catechol_iron_complex.psf

exit
