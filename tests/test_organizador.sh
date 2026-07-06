#!/bin/bash

# Diretório do teste
dir_test="/tmp/test_organizador"
test_hist="../logs/historico_teste.log"
test_manif="../logs/ultima_operacao_teste.tsv"

# Cria diretório do teste
mkdir $dir_test

# Cria os arquivos de teste
echo "teste com extensão .txt" > "$dir_test/anotacoes.txt"
echo "teste com extensão .html" > "$dir_test/pagina.html"

# Teste de organizacao dos arquivos
../scripts/organizar.sh $dir_test $test_hist $test_manif

echo -e "Esperado: arquivos organizados em diretórios"

if [[ -f "$dir_test/txt/anotacoes.txt" && -f "$dir_test/html/pagina.html" ]]; then
    echo -e "SUCESSO: Os arquivos foram organizados!"
else
    echo "ERRO: Os arquivos não foram organizados."
fi

# Teste de desfazer organizacao dos arquivos



# Limpa arquivos do teste
rm $dir_test -rf
rm $test_hist
rm $test_manif
