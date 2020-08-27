#!/bin/bash

# guard against missing or empty custom directory
[ -d config ] || echo -e "INFO || No custom config directory mounted\nINFO || Continuing..." && NO_CUSTOM_CONF=1
[ "`ls -d config/* &> /dev/null`" ] || echo -e "INFO || No custom config files available\nINFO || Continuing..." && NO_CUSTOM_CONF=1

# declare custom conf array if custom conf available
[ -z "${NO_CUSTOM_CONF}" ] && declare -rax CUSTOM_CONFIG_FILES=($(ls -d config/*))

# declare core conf array
declare -rax CORE_CONFIG_FILES=($(ls -d _config/*))

# link core conf files | suspectible for overwrite by custom conf files
for core in "${CORE_CONFIG_FILES[@]}"
do
    ln -s $core .
done

# link custom conf files | overwrite core files
for custom in "${CUSTOM_CONFIG_FILES[@]}"
do
    ln -sf $custom .
done