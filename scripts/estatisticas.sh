#!/bin/bash

HISTORICO="$1"

if [ -z "$HISTORICO" ]; then
    echo "Erro: uso correto -> $0 <arquivo_historico>"
    exit 1
fi

if [ ! -f "$HISTORICO" ] || [ ! -s "$HISTORICO" ]; then
    echo "Ainda não há estatísticas: nenhuma organização foi realizada."
    exit 0
fi

echo "----------------------------------"
echo " Estatísticas do Organizador"
echo "----------------------------------"

total=$(wc -l < "$HISTORICO")
echo "Total de arquivos organizados (histórico completo): $total"
echo ""

echo "Arquivos organizados por tipo:"
awk -F'\t' '{contagem[$2]++} END {for (t in contagem) print t, contagem[t]}' "$HISTORICO" \
    | sort -k2,2 -nr \
    | awk '{printf "  %-15s %d\n", $1, $2}'
echo ""

ultima_data=$(tail -n 1 "$HISTORICO" | cut -f1)
echo "Última organização realizada em: $ultima_data"
echo ""

echo "Pastas já organizadas:"
awk -F'\t' '{print $4}' "$HISTORICO" | sort -u | while read -r pasta; do
    echo "  - $pasta"
done

echo "----------------------------------"
