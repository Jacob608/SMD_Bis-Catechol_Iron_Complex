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

# Software

## Software Versions Used
- LAMMPS 3 Mar 2020
- Visual Molecular Dynamics version 1.9.3
- GNU Bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
- TCL version 8.6

## Software Setup

- VMD: Visual Molecular Dynamics is a molecular visualization program for displaying, animating, and analyzing large biomolecular systems using 3-D graphics and built-in scripting. VMD supports computers running MacOS X, Unix, or Windows, is distributed free of charge, and includes source code. [https://www.ks.uiuc.edu/Research/vmd/](https://www.ks.uiuc.edu/Research/vmd/)
- LAMMPS: Large-scale Atomic/Molecular Massively Parallel Simulator is a classical molecular dynamics code with a focus on materials modeling. It can be downloaded [here](https://www.lammps.org/download.html).
- CONDA: Conda is a tool for managing packages and environments. The file environment.yml can be used to create a conda environment loaded with Python and other software versions. Instructions on how to create a conda environment from a yml file can be found [here](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

# Instructions

There are three steps in this procedure. The first step is building a pdb, psf, and LAMMPS data file to prepare for a LAMMPS simulation. The second step is to run an equilibration of that system. The third step is to run and analyze a steered molecular dynamics simulation using LAMMPS fix smd. Set up your software as outlined in the section Software.

## Step 1: Prepare pdb, psf, and data files.

Run the command 'bash **make_data_file.sh**'.

- This will run all of the bash commands in '**make_data_file.sh**', using VMD's psfgen plugin to create a pdb and psf of the structures in **do2p_1.pdb**, **do2p_2.pdb**, and **fe3p.pdb**. It then runs a bash script called **run_c2l.sh**, which runs the charmm2lammps.pl script for converting pdb, psf, topology, and paramter files into LAMMPS readable data file format. The files required to run the charmm2lammps.pl script, including topology and parameter files are located in the **charmm2lammps_all36_tip3** directory. Files are then reorganized into the directory **smd_simulation**, which will now contain all the files necessary to run an equilibration and steered molecular dynamics simulation. Log files for tcl and bash scripts (**make_bis_catechol_iron_crosslink_psf.log**, **run_c2l.log**, and **solvate_ionized.log**) that are run by **make_data_file.sh** can be reviewed in the directory **smd_simulation/temp_files**. The **charmm2lammps_all36_tip3** directory, which contains all input files, output files, and the log file **charmm2lammps.log**, are copied into **smd_simulation** for your review.

## Step 2: Run a LAMMPS equilibration simulation.

1) Navigate into the directory **smd_simulation**.

2) Inspect the pdb and psf files you made by opening VMD and running the script **inspect_structure.vmd** with the command 'source inspect_structure.vmd'. It should look like the image below.
![Screenshot 2025-04-25 at 10 36 17 AM](https://github.com/user-attachments/assets/dc092978-fadb-46af-872f-ca7b77767a4e)

3) Run a LAMMPS equilibration simulation by running the command 'bash submit_equil.sh'. This will run the simulation in parallel on 4 processors by default. If you would like to submit the simulation to a Slurm workload managed system, run the script with the command 'sbatch submit_equil.sh'.

4) When the simulation is completed, inspect the trajectory by opening VMD and running the command 'source view_equil_solvated.vmd'.


## Step 3: Run a LAMMPS steered molecular dynamics simulation.

1) In submit_smd.sh modify the source activate line to point to an appropriate conda environment. Run either the command 'bash submit_smd.sh' or 'sbatch submit_smd.sh' if submitting to a Slurm workload managed system to run a steered molecular dynamics simulation.

- The script **submit_smd.sh** contains commands to run a python script **calculate_xyz_for_fixsmd.py**, which takes the data file **equilibrated.data** generated at the end of the equilibration simulation and calculates the x, y, and z coordinates of the point to which the smd spring will be tethered. The script **calculate_xyz_for_fixsmd.py** sets the tether point by finding the point that is 10 Angstroms away from the pull atom, attached to the other end of the spring, in the direction of the vector pointing from the fix atom to the pull atom:

![Screenshot 2025-04-25 at 10 50 48 AM](https://github.com/user-attachments/assets/8e29dbf9-4a24-4a2e-b2f7-7a3b5804b7fc)

2) When the simulation is completed, inspect the trajectory by opening VMD and running the command 'source view_smd_solvated.vmd'.

3) Perform a quick analysis of the SMD results by navigating back into the main directory and running the Jupyter Notebook **smd_analysis.ipynb**.


