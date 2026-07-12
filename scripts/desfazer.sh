#!/bin/bash

MANIFESTO="$1"

if [ -z "$MANIFESTO" ]; then 
    echo "Erro: tente -> <arquivo_manifesto>"
    exit 1
fi

if [ ! -f "$MANIFESTO" ] || [ ! -s "$MANIFESTO" ]; then
    echo "Não há nenhuma organização recente para desfazer"
    exit 0
fi

echo "Desfazendo última organização..."
echo "----------------------------------"

total_restaurados=0
total_falhas=0

if command -v tac >/dev/null 2>&1; then
    linhas=$(tac "$MANIFESTO")
else 
    linhas=$(tail -r "$MANIFESTO")
fi

while IFS=$'\t' read -r destino origem; do

    if [ -f "$destino" ]; then
        mkdir -p "$(dirname "$origem")"
        mv "$destino" "$origem"

        if [ $? -eq 0 ]; then
            echo " [SUCESSO] $(basename "$destino") -> $(dirname "$origem")/"
            total_restaurados=$((total_restaurados + 1))
        
        else 
            echo " [FALHA] Não foi possível restaurar $(basename "$destino")"
            total_falhas=$((total_falhas + 1))
        
        fi

        else
        echo "  [AVISO] Arquivo não encontrado, pulando: $destino"
        total_falhas=$((total_falhas + 1))

        fi

done <<< "$linhas"

echo "----------------------------------"
echo "Total de arquivos restaurados: $total_restaurados"

if [ "$total_falhas" -gt 0 ]; then
echo "Total de itens com falha/aviso: $total_falhas"
    
fi

> "$MANIFESTO"
