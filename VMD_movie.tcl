#!/bin/tcl

#Set box dimensions for all frames
pbc set {A B C alpha beta gamma} -all

# Change background color
color Display Background white

#Time bar set by default to 0.5 fs/MM_step & tick every 500 fs
#arguments: time_value_of_1_snapshot time_between_ticks  "unit" 0
# example below: 1 tick every 500 fs with 0.5 fs between snapshots
proc do_time {args} {display_time_bar 0.5 500 "fs" 0}
trace variable vmd_frame(0) w do_time
animate goto start

# Moving the box around
# Move the system
  # Apply PBC to wrap within the same unit cell while keeping fragments, e.g. H2O, together
pbc wrap -compound res -all
  # Select the first molecule object in VMD
mol top 0
  # Adjust zoom on this system
scale to 0.07
  # Translate system
translate to -0.1 0.75 0

# Move the timebar
  # Fix the first molecule object
mol fix 0
  # Release the molecule object corresponding to the time bar
mol free 1
scale to 0.8
translate to 1.85 0 0

  # Fix the time bar and release the chemical system
mol fix 1 
mol free 0


#Representations
  # Delete all existing representations
mol delrep all 0 

#mol showperiodic <molecule_id> <representation_id> [flags]

# First representation with Z periodic image
  # Change coloring method
mol color Name
  # Configure representation type and parameter
mol representation DynamicBonds 1.8 0.1 12
  # Change material type
mol material Opaque
  # Change selection
mol selection {type B C N}
  # Create the thus configured representation
mol addrep top
  # Display the Z periodic image of the representation 0 of the 0th molecule object
mol showperiodic 0 0 Z


# Second representation
mol color Name
mol representation CPK 0.4 0.0 8 8
mol material Opaque
mol selection {type B C N}
mol addrep top
mol showperiodic 0 1 Z

# 2 representations for water molecules
mol color Name
mol representation DynamicBonds 1.2 0.1 12
mol materil Opaque
mol selection {type O H}
mol addrep top

mol color Name
mol representation CPK 0.4 0.0 8 8
mol material Opaque
mol selection {type O H}
mol addrep top


# 2 representations for a specific part of the system
mol color ColorID 22
mol representation CPK 1.0 0.4 12 12
mol material Opaque
mol selection {index 726 727 728}
mol addrep top

mol color ColorID 22
mol representation DynamicBonds 1.6 0.1 12
mol material Opaque
mol selection {type O B C and within 1.6 of index 726}
mol addrep top


