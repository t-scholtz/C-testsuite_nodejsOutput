#!/bin/bash
rm error_in_output.txt 

cd differences

FILE=""
DIR="C_Diff"

for folder in *; do
    sleep 1
    cd $folder
    cd Wasm_out
    python3  ../../../cleanDataC.py
    cd ..
    sleep 1
    cd C_out
    python3  ../../../cleanDataC.py
    
    sleep 2

    file=$folder".txt"
    filePath="/home/parallels/Desktop/test/wasmfiles/results/"$file
    touch $filePath
    echo  $folder"" >>  $filePath

    #Append output + differences
    declare -i count;
    count=-1;
    for mutant in *.txt; do
    	count+=1
        file_name=${mutant%".txt"}
        
        
        if ! cmp --silent -- $mutant ../Wasm_out/$file_name".txt";
        then
            echo "Diff Found" + $mutant  >> $filePath
            diff $mutant ../Wasm_out/$file_name".txt" >>$filePath
        fi

   
    done
    cd ..
    cd ..
    echo "Number of Mutants in $folder is = $count _mod" >>$filePath;
done

cd ..

python anaylseData.py 



