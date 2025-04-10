<!-- For developers:
Please use bold font for file names, directories, and file paths.
Please use italic font for variables.
Follow heading styles.
# First-level heading
## Second-level heading
### Third-level heading
See https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax for formatting syntax.
-->
# Summary

This repository demonstrates how to create a PSF file from a PDB structure of either the bis-catechol iron complex shown (below left) or the covalent dityrosine crosslink (shown right) before running a steered molecular dynamics simulation in LAMMPS to analyze its force-displacement response. The bis-catechol complex consists of two divalent DOPA residues with ionized alcohol oxygens coordinating with a trivalent iron cation. The dityrosine crosslink forms when an aromatic carbon on one tyrosine sidechain bonds to an aromatic carbon on another tyrosine. The model is simulated with the CHARMM36 pairwise additive force field. Parameters for divalent DOPA and the dityrosine crosslink were obtained using CGenFF program version 4.0.

<img width="273" alt="image" src="https://github.com/user-attachments/assets/ea51565e-e1fc-46c6-a6e2-4136b4af3b86" /> ![image](https://github.com/user-attachments/assets/ad39ce75-e40d-4a45-b2c7-8c2b0b3861c4)

# Software Versions Used
- LAMMPS 3 Mar 2020
- Visual Molecular Dynamics version 1.9.3
- GNU Bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
- TCL version 8.6

## Software Setup

- VMD: Visual Molecular Dynamics is a molecular visualization program for displaying, animating, and analyzing large biomolecular systems using 3-D graphics and built-in scripting. VMD supports computers running MacOS X, Unix, or Windows, is distributed free of charge, and includes source code. [https://www.ks.uiuc.edu/Research/vmd/](https://www.ks.uiuc.edu/Research/vmd/)
- LAMMPS: Large-scale Atomic/Molecular Massively Parallel Simulator is a classical molecular dynamics code with a focus on materials modeling. It can be downloaded [here](https://www.lammps.org/download.html).
- CONDA: Conda is a tool for managing packages and environments. The file environment.yml can be used to create a conda environment loaded with Python and other software versions. Instructions on how to create a conda environment from a yml file can be found [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).
