#!/bin/bash

clear

VERMELHO='\033[1;31m'
AZUL='\033[1;36m'
NC='\033[0m'

ERROS=0

# Diretório do teste
dir_test="/tmp/test_organizador"
test_hist="../logs/historico_teste.log"
test_manif="../logs/ultima_operacao_teste.tsv"

rm $dir_test -rf &> /dev/null

# Cria diretório do teste
mkdir $dir_test

# Cria os arquivos de teste
echo "teste-txt" > "$dir_test/anotacoes.txt"
echo "teste-html" > "$dir_test/pagina.html"

# Teste de organizacao dos arquivos
NOME_TESTE="Teste de organização em diretórios"

../scripts/organizar.sh $dir_test $test_hist $test_manif &> /dev/null

if [[ -f "$dir_test/txt/anotacoes.txt" && -f "$dir_test/html/pagina.html" ]]; then
    echo -e "$NOME_TESTE [${AZUL}SUCESSO${NC}]"
else
    ((ERROS++))
    echo -e "$NOME_TESTE [${VERMELHO}FALHOU${NC}]"
fi

# Teste do conteúdo dos arquivos
NOME_TESTE="Teste de conteúdo dos arquivos"

CONTEUDO_TXT=$(cat $dir_test/txt/anotacoes.txt)
CONTEUDO_HTML=$(cat $dir_test/html/pagina.html)

if [ "$CONTEUDO_TXT" == "teste-txt" ] && [ "$CONTEUDO_HTML" == "teste-html" ]; then
    echo -e "$NOME_TESTE [${AZUL}SUCESSO${NC}]"
else
    ((ERROS++))
    echo -e "$NOME_TESTE [${VERMELHO}FALHOU${NC}]"
fi

# Teste de desfazer organizacao dos arquivos
NOME_TESTE="Teste de desfazer organização em diretórios"

../scripts/desfazer.sh "$test_manif" &> /dev/null

if [[ -f "$dir_test/anotacoes.txt" && -f "$dir_test/pagina.html" ]]; then
    echo -e "$NOME_TESTE [${AZUL}SUCESSO${NC}]"
else
    ((ERROS++))
    echo -e "$NOME_TESTE [${VERMELHO}FALHOU${NC}]"
fi


# Resultado final
if [[ $ERROS -eq 0 ]]; then
    echo -e "${AZUL}Todos os testes foram bem sucedidos${NC}\n"
else
    echo -e "${VERMELHO}Falha em um ou mais testes${NC}\n"
fi

# Limpa arquivos do teste
rm $dir_test -rf
rm $test_hist
rm $test_manif
