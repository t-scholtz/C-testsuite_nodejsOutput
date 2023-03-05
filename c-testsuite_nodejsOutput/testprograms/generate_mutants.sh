#!/bin/bash



python conv.py

cd raw_programs
for file in *.c; do
mv $file ../../wasmfiles/mutantprograms/
done

cd ../../wasmfiles
bash conv.sh



