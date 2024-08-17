#!/bin/bash


MOVIES=("RRR" "DJTILLU" "MURALI")

# size of above array is 3.
# index are 0,1,2,

# list always starts with 0.

echo "first Movie is: ${MOVIES{0}}"
echo "first Movie is: ${MOVIES{1}}"
echo "first Movie is: ${MOVIES{@}}"