#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmshiv/locale

pot-create -o unicorecmshiv/locale/unicorecmshiv.pot unicorecmshiv/

declare -a arr=("eng_GB")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmshiv/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmshiv/locale/""$lang""/LC_MESSAGES/unicorecmshiv.po" ]; then
        msginit -l $lang -i unicorecmshiv/locale/unicorecmshiv.pot -o unicorecmshiv/locale/$lang/LC_MESSAGES/unicorecmshiv.po
    fi

    msgmerge --update unicorecmshiv/locale/$lang/LC_MESSAGES/unicorecmshiv.po unicorecmshiv/locale/unicorecmshiv.pot
    msgfmt unicorecmshiv/locale/$lang/LC_MESSAGES/*.po -o unicorecmshiv/locale/$lang/LC_MESSAGES/unicorecmshiv.mo
done
