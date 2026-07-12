#!/bin/bash

echo "== Testando scripts/estatisticas.sh =="

dir_test=$(mktemp -d)
test_hist="$dir_test/historico_teste.log"

{
    printf "2026-07-01 10:00:00\tpdf\trelatorio.pdf\t/tmp/pastaA\n"
    printf "2026-07-01 10:00:01\tpdf\tcontrato.pdf\t/tmp/pastaA\n"
    printf "2026-07-02 09:30:00\tjpg\tfoto.jpg\t/tmp/pastaB\n"
} > "$test_hist"

saida=$(../scripts/estatisticas.sh "$test_hist")

echo -e "Esperado: total de 3 arquivos, 2 pdf, 1 jpg"

if [[ "$saida" == *"Total de arquivos organizados (histórico completo): 3"* ]]; then
    echo "SUCESSO: total geral está correto."
else
    echo "ERRO: total geral incorreto."
fi

if [[ "$saida" == *"pdf"*"2"* ]]; then
    echo "SUCESSO: contagem de pdf está correta."
else
    echo "ERRO: contagem de pdf incorreta."
fi

if [[ "$saida" == *"jpg"*"1"* ]]; then
    echo "SUCESSO: contagem de jpg está correta."
else
    echo "ERRO: contagem de jpg incorreta."
fi

rm "$dir_test" -rf
