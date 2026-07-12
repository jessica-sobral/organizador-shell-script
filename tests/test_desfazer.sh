#!/bin/bash

echo "== Testando scripts/desfazer.sh =="

dir_test=$(mktemp -d)
mkdir "$dir_test/pdf"
echo "conteudo de teste" > "$dir_test/pdf/relatorio.pdf"

test_manif="$dir_test/manifesto_teste.tsv"
printf "%s\t%s\n" "$dir_test/pdf/relatorio.pdf" "$dir_test/relatorio.pdf" > "$test_manif"

../scripts/desfazer.sh "$test_manif" > /dev/null

echo -e "Esperado: arquivo deve voltar para o diretório original"

if [[ -f "$dir_test/relatorio.pdf" ]]; then
    echo "SUCESSO: arquivo restaurado no diretório original!"
else
    echo "ERRO: arquivo não foi restaurado."
fi

if [[ ! -f "$dir_test/pdf/relatorio.pdf" ]]; then
    echo "SUCESSO: arquivo não está mais na subpasta pdf!"
else
    echo "ERRO: arquivo ainda está na subpasta pdf."
fi

rm "$dir_test" -rf
