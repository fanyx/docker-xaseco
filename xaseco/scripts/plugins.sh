#!/bin/bash

declare -rx XML_HEADER='<?xml version="1.0" encoding="utf-8" ?>\n<aseco_plugins>\n'
declare -rx XML_FOOTER='</aseco_plugins>'
declare -rax PLUGINS_LIST=($(ls -d plugins/*.php | sed -e 's/\plugins\///g'))

# echo "${PLUGINS_LIST[@]}"


{
    # open with header -- \n interpreted
    printf "%b" "$XML_HEADER"

    # main block -- parse plugin list
    {
        [[ "${PLUGINS_LIST[@]}" =~ "plugin.localdatabase.php" ]] && printf "  <plugin>plugin.localdatabase.php</plugin>\n"
        for plugin in "${PLUGINS_LIST[@]}"
        do
            case "${plugin}" in
                "plugin.localdatabase.php")
                    ;;
                *)
                    printf "  <plugin>%s</plugin>\n" "${plugin}"
                    ;;
            esac
        done
    }

    # finish with footer -- \n interpreted
    printf "%b" "$XML_FOOTER"
} > plugins.xml