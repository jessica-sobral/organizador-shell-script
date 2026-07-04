#!/bin/bash
#
# organizar.sh - move os arquivos de um diretório para subpastas de acordo
# com sua extensão, evitando sobrescrever arquivos com o mesmo nome e
# registrando cada movimentação (para estatísticas e para permitir desfazer).
#
# uso: ./organizar.sh <diretorio> <arquivo_historico> <arquivo_manifesto>

DIRETORIO="$1"
HISTORICO="$2"
MANIFESTO="$3"

if [ -z "$DIRETORIO" ] || [ -z "$HISTORICO" ] || [ -z "$MANIFESTO" ]; then
    echo "Erro: uso correto -> $0 <diretorio> <historico> <manifesto>"
    exit 1
fi

if [ ! -d "$DIRETORIO" ]; then
    echo "Erro: '$DIRETORIO' não é um diretório válido."
    exit 1
fi

# zera o manifesto: só guardamos a última organização, para o "desfazer"
> "$MANIFESTO"

echo "Organizando arquivos em: $DIRETORIO"
echo "--------------------------------------------------"

total_movidos=0
total_ignorados=0

# estrutura de repetição (for) percorrendo os itens do diretório
for arquivo in "$DIRETORIO"/*; do

    # processa apenas arquivos (ignora subpastas já existentes)
    if [ -f "$arquivo" ]; then
        nome_arquivo=$(basename "$arquivo")
        extensao="${nome_arquivo##*.}"

        # estrutura condicional: trata arquivos sem extensão
        if [ "$extensao" == "$nome_arquivo" ]; then
            pasta_destino="Sem_Extensao"
        else
            pasta_destino=$(echo "$extensao" | tr '[:upper:]' '[:lower:]')
        fi

        mkdir -p "$DIRETORIO/$pasta_destino"

        destino="$DIRETORIO/$pasta_destino/$nome_arquivo"

        # estrutura de repetição (while) para evitar sobrescrever arquivos
        # com o mesmo nome, criando um sufixo numérico incremental
        contador=1
        nome_base="${nome_arquivo%.*}"
        while [ -e "$destino" ]; do
            if [ "$extensao" == "$nome_arquivo" ]; then
                destino="$DIRETORIO/$pasta_destino/${nome_base}_$contador"
            else
                destino="$DIRETORIO/$pasta_destino/${nome_base}_$contador.$extensao"
            fi
            contador=$((contador + 1))
        done

        mv "$arquivo" "$destino"

        if [ $? -eq 0 ]; then
            echo "  [OK] $nome_arquivo -> $pasta_destino/"
            total_movidos=$((total_movidos + 1))

            # registra no manifesto (para permitir desfazer depois)
            printf "%s\t%s\n" "$destino" "$arquivo" >> "$MANIFESTO"

            # registra no histórico (para as estatísticas)
            printf "%s\t%s\t%s\t%s\n" \
                "$(date '+%Y-%m-%d %H:%M:%S')" "$pasta_destino" "$nome_arquivo" "$DIRETORIO" \
                >> "$HISTORICO"
        else
            echo "  [FALHA] Não foi possível mover $nome_arquivo"
            total_ignorados=$((total_ignorados + 1))
        fi
    fi
done

echo "--------------------------------------------------"
echo "Total de arquivos organizados: $total_movidos"

if [ "$total_ignorados" -gt 0 ]; then
    echo "Total de arquivos com falha: $total_ignorados"
fi

if [ "$total_movidos" -eq 0 ]; then
    echo "Nenhum arquivo novo para organizar nessa pasta."
fi