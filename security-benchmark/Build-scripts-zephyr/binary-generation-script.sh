#!/bin/bash
#This script automates the binary generation with given CVE, BOARD and sample

set -x
set -e

cd $ZEPHYR_BASE_DIR

# Restore git state
git reset --hard
git clean -df
git checkout "$BASE_COMMIT"
west update

# Backport fix for device binding bug
git cherry-pick 5b36a01a67dd705248496ef46999f39b43e02da9 --no-commit

# Revert the changes that fixed the issue (but keep the other fixes)
for commit in $FIX_COMMITS; do
    git revert "$commit" -n
done

# Apply the patches if any
for patch in $PATCHES; do
    git apply $PATCH_DIR/$patch 
    echo "Applied $patch"
done

# Generating a list of boards from the env variable defined
INDEX=0
for name in $BOARD_NAMES; do
    BOARD_NAME[$INDEX]=$name
    INDEX=$(( $INDEX + 1 ))
done


# Build sample
INDEX=0
for BOARD in $BOARDS; do
    
    cd $OUT_DIR
    mkdir ${BOARD_NAME[$INDEX]}

    for SAMPLE in $SAMPLE_DIR; do
        if [ -d $SAMPLE ]; then
            cd $SAMPLE
            rm -rf build

            SAMPLE_NAME="$(basename -- $SAMPLE)"
            SAMPLE_CLASS=$(echo "$SAMPLE" | cut -d / -f 7)

            if [ -d $OUT_DIR/${BOARD_NAME[$INDEX]}/$SAMPLE_CLASS-$SAMPLE_NAME ]; then
                rm -rf $OUT_DIR/${BOARD_NAME[$INDEX]}/$SAMPLE_CLASS-$SAMPLE_NAME;
            fi
        
            mkdir $OUT_DIR/${BOARD_NAME[$INDEX]}/$SAMPLE_CLASS-$SAMPLE_NAME
            west build --pristine always -b "$BOARD" || true

            if [ -f build/zephyr/zephyr.elf ]; then
                cp build/zephyr/zephyr.elf $OUT_DIR/${BOARD_NAME[$INDEX]}/$SAMPLE_CLASS-$SAMPLE_NAME/$CVENUM-"$BOARD".elf
            fi
            if [ -f build/zephyr/zephyr.bin ]; then  
                cp build/zephyr/zephyr.bin $OUT_DIR/${BOARD_NAME[$INDEX]}/$SAMPLE_CLASS-$SAMPLE_NAME/$CVENUM-"$BOARD".bin
            fi
            rm -rf build
        fi   
    done   

    cd $OUT_DIR/${BOARD_NAME[$INDEX]}
    find . -type d -empty -delete
    INDEX=$(( $INDEX + 1 ))
    
done

echo "==================== Binary generation for $BOARDS completed ===================="