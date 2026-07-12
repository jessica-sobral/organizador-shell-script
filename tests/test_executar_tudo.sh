#!/bin/bash

echo "----------------------------------"
echo " Executar todo o Organizador"
echo "----------------------------------"

total_erros=0

for arquivo_teste in test_*.sh; do

    if [[ "$arquivo_teste" == "test_executar_tudo.sh" ]]; then
        continue
    fi

    echo ""
    echo "----------------------------------"
    echo "Rodando: $arquivo_teste"
    echo "----------------------------------"

    saida=$(bash "$arquivo_teste")
    echo "$saida"

    erros_deste_teste=$(echo "$saida" | grep -Ec "ERRO|FALHOU")
    total_erros=$((total_erros + erros_deste_teste))
done

echo ""
echo "----------------------------------"
if [ "$total_erros" -eq 0 ]; then
    echo "Resultado Final: Todos os testes passaram"
else
    echo "Resultado Final: $total_erros Verificações falharam"
fi
echo "----------------------------------"

exit $total_erros
