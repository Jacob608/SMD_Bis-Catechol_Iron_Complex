#!/usr/bin/env python
# coding: utf-8

# # Return x, y, and z for SMD Pull Direction

# Import necessary libraries
import MDAnalysis as mda
import argparse
import numpy as np

# Read the information requested by the user.
parser = argparse.ArgumentParser(description="Process some integers.")
# idx1 is the index of the atom which will be fixed during the smd simulation.
parser.add_argument('-idx1', type=int, help='First index')
# idx2 is the index of the atom which will be attached to the spring during the smd simulation.
parser.add_argument('-idx2', type=int, help='Second index')
# f is the name of the data file from which the positions of id1 and id2 will be extracted.
parser.add_argument('-f', type=str, help='LAMMPS data file name.')
# tether_dist is the initial distance between the pull atom and the other end of the smd spring.
parser.add_argument('-tether_dist', type=str, help='Distance between pull atom and other end of smd spring.')

args = parser.parse_args()
idx1 = args.idx1
idx2 = args.idx2
f = args.f
tether_dist = args.tether_dist

def unit_vector(pos1, pos2):
    """
    Description: Calculate the unit vector pointing from coordinates of pos1 to coordinates in pos2.
    
    Args:
        pos1 (array): An array of Cartesian coordinates x, y, and z.
        pos2 (array): An array of Cartesian coordinates x, y, and z.
    
    Returns:
        unit_vec (array): An array of Cartesian coordinates x, y, and z which is also the unit vector between pos1 and pos2.
    """
    # Calculate the magnitude of the vector from pos1 to pos2.
    delta_x = pos2[0] - pos1[0]
    delta_y = pos2[1] - pos1[1]
    delta_z = pos2[2] - pos1[2]
    magnitude = (delta_x ** 2 + delta_y ** 2 + delta_z ** 2) ** 0.5
    
    # Convert the difference between pos2 and pos1 into a unit vector.
    unit_vec = np.asarray([delta_x, delta_y, delta_z]/magnitude)
    
    # Make sure that this is a unit vectorto two decimal places.
    assert np.round(np.sqrt(unit_vec[0]**2 + unit_vec[1]**2 + unit_vec[2]**2), 2) == 1.0
    
    return unit_vec

# Load the requested data file into a MDAnalysis universe.
u = mda.Universe(f)
# Get the positions of the two reference atoms.
pos1 = u.select_atoms(f"index {idx1}").positions[0]
pos2 = u.select_atoms(f"index {idx2}").positions[0]
# Get a unit vector pointing in the direction from pos1 to pos2.
unit_vec = unit_vector(pos1, pos2)
# Print the x, y, and z coordinates of the unit vector to a text file.
with open('xyz.txt', 'w') as file:
    file.write(f"{pos2[0] + tether_dist * unit_vec[0]} {pos2[1] + tether_dist * unit_vec[1]} {pos2[2] + tether_dist * unit_vec[2]}")





