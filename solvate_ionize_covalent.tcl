package require solvate
package require autoionize

mol new covalent_complex.psf
mol addfile covalent_complex_noTER.pdb

solvate covalent_complex.psf covalent_complex_noTER.pdb -t 20 -o covalent_complex_solvated

autoionize -psf covalent_complex_solvated.psf -pdb covalent_complex_solvated.pdb -sc 0.15 -cation SOD -anion CLA

exit