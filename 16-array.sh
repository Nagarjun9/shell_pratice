#!/bin/bash


MOVIES=("RRR" "DJTILLU" "MURALI")

# size of above array is 3.
# index are 0,1,2,

# list always starts with 0.

echo "firsh Movie is: ${MOVIES{1}}"
echo "firsh Movie is: ${MOVIES{2}}"
echo "firsh Movie is: ${MOVIES{@}}"