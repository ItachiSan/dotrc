# Some functions I've gathered during the years for building properly Android ROMs

# Make an Android build and show you start and end time
bacon_counter (){
    START=$(date)
    lunch
    make bacon

    echo
    echo 'Task started at:' $START
    echo 'Task ended at:' $(date)
    echo
}
 
#Same, but with recovery image
recovery_counter (){
    START=$(date)
    lunch
    make recoveryimage

    echo
    echo 'Task started at:' $START
    echo 'Task ended at:' $(date)
    echo
}
 
# Export variables in order to build Android like a boss
android_build_env () {
 
    # Variable for correct folder    
    WORK_PATH=$(pwd)
   
    echo
    echo "Preparing workspace in" $WORK_PATH
    echo
 
    # Exporting right paths
    echo "Setting up \$PATHs"
    
    echo 'Android Tools...'
    # Android tools
    export PATH="/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/opt/android-build:$PATH"
    
    echo 'Sun Java 6...'
    # Java6
    export J2SDKDIR=/opt/java6
    export PATH=/opt/java6/bin:/opt/java6/db/bin:$PATH
    export JAVA_HOME=/opt/java6
    export DERBY_HOME=/opt/java6/db
 
    echo
    echo "Changing directory and setting compiler variables..."
    cd $WORK_PATH
   
    # Compiler declarations
    export ARCH=arm
    export SUBARCH=arm
    export CROSS_COMPILE=arm-eabi-
    
    ## For using prebuilt toolchains
    #export PATH="$WORK_PATH/prebuilts/arm-eabi-4.6/arm-eabi/bin/:$PATH"
    #export PATH="$WORK_PATH/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/:$PATH"
    ## If using gcc-multilib 4.4 (AUR for archlinux)
    #export CC=gcc-4.4
    #export CXX=g++-4.4
    ## As I've problems with make 4, I use make 3.81
    #alias make='make-3.81'
    ## Created a symlink between '/usr/bin/make-3.81' and '/opt/android-build/make' so we should use correct make    
    ## Also, in this way, we switch back to make 4 when we close the terminal

    # Test for building
    export CC=gcc-4.4
    export CXX=g++-4.4

    echo
    echo "Setting up ccache"
    # CCache
    export USE_CCACHE=1
    export CCACHE_DIR=./ccache

    export OUT_DIR_COMMON_BASE=/mnt/android/out
    # Check where we have ccache (differs from ICS<= and JB)
    CCACHE_BIN_DIR=./prebuilt/linux-x86/ccache
    if [ -d "./prebuilts/misc/linux-x86/ccache" ]; then
    CCACHE_BIN_DIR=./prebuilts/misc/linux-x86/ccache
    # We build on another partition - we can as we're on Android >= 4.1
    export CCACHE_DIR=$OUT_DIR_COMMON_BASE/ccache/$(basename $WORK_PATH)
    # Let's be sure to have ccache directory
    mkdir -p $CCACHE_DIR
    fi
    
    # We're not on >=JB? Let's move ccache anyways
    if [[ $CCACHE_DIR == "./ccache" ]]; then 
    export CCACHE_DIR=/mnt/android/out/ccache/$(basename $WORK_PATH)
    mkdir -p $CCACHE_DIR
    fi
    
    # Manage ccache at your wish ;) I set 15G as I can
    $CCACHE_BIN_DIR/ccache -M 15G

    echo "Setting up out"
    if [ ! -h ./out ]; then
    export OUT_DIR_GOOD=$OUT_DIR_COMMON_BASE/$(basename $WORK_PATH)
    mkdir -p $OUT_DIR_GOOD
    rm -i ./out
    ln -s $OUT_DIR_GOOD out
    fi
    
    echo
    echo "Reading devices configs..."
    echo
    source build/envsetup.sh
    # Ready for building Android
    echo
    echo "### Android Build Environment ready!###"
    echo
}
