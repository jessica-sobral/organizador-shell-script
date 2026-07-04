# Organizador Automático de Arquivos
 
Sistema em Shell Script (Bash) que organiza arquivos automaticamente em
subpastas por tipo/extensão, mantém estatísticas de uso e permite desfazer
a última organização feita. Projeto desenvolvido para a disciplina de
Sistemas Operacionais / Shell Script.
 
## Menu
 
```
======================================
 ORGANIZADOR AUTOMÁTICO DE ARQUIVOS
======================================
1 - Organizar Downloads
2 - Organizar outra pasta
3 - Mostrar estatísticas
4 - Desfazer última organização
5 - Ajuda
6 - Sair
======================================
```

## Problema resolvido
 
A pasta Downloads (ou qualquer pasta de trabalho) costuma acumular
arquivos de tipos variados (PDF, imagens, planilhas, instaladores etc.)
sem nenhuma organização. Este projeto automatiza a separação desses
arquivos em subpastas por tipo, sem risco de perda de dados, já que é
possível desfazer a última operação a qualquer momento.

## Como executar
 
Pré-requisitos: Linux/WSL com `bash`, `tac` (ou `tail -r` como alternativa,
já tratado no script), `find`, `mv`, `mkdir`.
 
```bash
chmod +x organizador.sh scripts/*.sh tests/*.sh
./organizador.sh
```
 
### Usando o Makefile
 
```bash
make run     # ajusta permissões e já abre o menu
make clean   # limpa os logs (histórico e manifesto)
```

## Detalhes importantes de funcionamento
 
- **Nomes duplicados:** se já existir um arquivo com o mesmo nome na pasta
  de destino, o script adiciona um sufixo numérico (`foto_1.jpg`,
  `foto_2.jpg`...) em vez de sobrescrever.
- **Arquivos sem extensão:** vão para uma subpasta chamada `Sem_Extensao`.
- **Desfazer:** só é possível desfazer a **última** organização realizada
  (o manifesto é sobrescrito a cada nova execução das opções 1 ou 2).
  Depois de desfazer, o manifesto é esvaziado.
- **Estatísticas:** são cumulativas, guardadas em `logs/historico.log`, e
  mostram total de arquivos organizados, contagem por tipo, data da
  última organização e quais pastas já foram organizadas.
