#!/usr/bin/env bash

site_packages=$(python3 -c "import site; print(site.getsitepackages()[0])")
curl https://raw.githubusercontent.com/boydfd/one_step_solve/master/resources/SimHei.ttf -o ${site_packages}/matplotlib/mpl-data/fonts/ttf/SimHei.ttf
backup=${site_packages}/matplotlib/mpl-data/matplotlibrc_backup
rc=${site_packages}/matplotlib/mpl-data/matplotlibrc

if [[ ! -f ${backup} ]]
then
echo backup rc
cp ${rc}  ${backup}
fi

add_config() {
text=$1
path=$2
check_regex=$(grep -E "([^#]|^)$text" ${path})
if [[ x${check_regex} == x'' ]]
then
    echo ${text} >> ${path}
    echo "add  ${text}"
fi
}
font_family='font.family : sans-serif'
sans_serif='font.sans-serif : SimHei'
axes_unicode_minus='axes.unicode_minus : False # use unicode for the minus symbol'
path=${rc}

add_config "${font_family}" "${path}"
add_config "${sans_serif}" "${path}"
add_config "${axes_unicode_minus}" "${path}"

rm -rf ~/.matplotlib/*.cache
rm ~/.matplotlib/fontlist-v310.json
rm ~/.matplotlib/*.json
