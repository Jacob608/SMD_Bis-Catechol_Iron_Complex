package require solvate
package require autoionize

mol new bis_catechol_iron_complex.psf
mol addfile bis_catechol_iron_complex_noTER.pdb

solvate bis_catechol_iron_complex.psf bis_catechol_iron_complex_noTER.pdb -t 20 -o bis_catechol_iron_complex_solvated

autoionize -psf bis_catechol_iron_complex_solvated.psf -pdb bis_catechol_iron_complex_solvated.pdb -sc 0.15 -cation SOD -anion CLA

exit