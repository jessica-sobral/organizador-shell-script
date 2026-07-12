#!/bin/bash

echo "-- Testando scripts/ajuda.sh --"

saida=$(../scripts/ajuda.sh)

echo -e "Esperado: ajuda deve mencionar as opções do menu"

if [[ "$saida" == *"Organizar Downloads"* ]]; then
    echo "SUCESSO: menção a 'Organizar Downloads' encontrada."
else
    echo "ERRO: 'Organizar Downloads' não encontrada na ajuda."
fi

if [[ "$saida" == *"Desfazer"* ]]; then
    echo "SUCESSO: menção a 'Desfazer' encontrada."
else
    echo "ERRO: 'Desfazer' não encontrada na ajuda."
fi

if [[ "$saida" == *"Sem_Extensao"* ]]; then
    echo "SUCESSO: menção a 'Sem_Extensao' encontrada."
else
    echo "ERRO: 'Sem_Extensao' não encontrada na ajuda."
fi
