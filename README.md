# Organizador Automático de Arquivos
 
Sistema em Shell Script (Bash) que organiza arquivos automaticamente em subpastas por tipo/extensão, mantém estatísticas de uso e permite desfazer a última organização feita. Projeto desenvolvido para a disciplina de Sistemas Operacionais / Shell Script.

## Problema resolvido
 
A pasta Downloads (ou qualquer pasta de trabalho) costuma acumular arquivos de tipos variados (PDF, imagens, planilhas, instaladores etc.) sem nenhuma organização. Este projeto automatiza a separação desses arquivos em subpastas por tipo, sem risco de perda de dados, já que é possível desfazer a última operação a qualquer momento.

## Menu 
 
```bash
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

## Como executar

### Pré-requisitos
- Sistema Linux, WSL ou Git Bash (Windows)
- `bash` instalado
- Comando `make` instalado (opcional, apenas se for usar o Makefile)
 
### Passo a passo

1. Clone o repositório:
```bash
   git clone 
   cd organizador
```

2. Dê permissão de execução aos scripts:
```bash
   chmod +x organizador.sh scripts/*.sh tests/*.sh
```
   (ou, se preferir, use `make permissoes`)

3. Execute o programa:
```bash
   bash organizador.sh
```
   (ou `make run`)

4. O menu será exibido no terminal. Digite o número da opção desejada
   (1 a 6) e pressione ENTER.

5. Para rodar os testes automatizados:
```bash
   bash tests/test_organizador.sh
```
   (ou `make test`)

6. Para limpar os logs (histórico e manifesto) e recomeçar do zero:
```bash
   make clean
```

## Detalhes importantes de funcionamento
 
- **Nomes duplicados:** se já existir um arquivo com o mesmo nome na pasta de destino, o script adiciona um sufixo numérico (`foto_1.jpg`, `foto_2.jpg`...) em vez de sobrescrever.
- **Arquivos sem extensão:** vão para uma subpasta chamada `Sem_Extensao`.
- **Desfazer:** só é possível desfazer a **última** organização realizada (o manifesto é sobrescrito a cada nova execução das opções 1 ou 2). Depois de desfazer, o manifesto é esvaziado.
- **Estatísticas:** são cumulativas, guardadas em `logs/historico.log`, e mostram total de arquivos organizados, contagem por tipo, data da última organização e quais pastas já foram organizadas.

## Testes

Os testes cobrem: organização de arquivos, geração correta de estatísticas, tratamento de nomes duplicados e o fluxo completo de desfazer.

## Linguagens & Ferramentas

- Shell Script (Bash)
- Makefile
- VS Code
- Git e Git Bash
- GitHub
- Terminal/Bash do Linux (ou WSL)
- Claude
- Gemini
- Chat GPT

## Organização do grupo & Responsabilidades

O projeto foi dividido entre os 3 integrantes do grupo, cobrindo as áreas de automação, estrutura do sistema, controle de versão, documentação, testes e apresentação final.

| Integrante | Responsabilidades | Arquivos / Evidências da contribuição |
|---|---|---|
| **Isabelle Sena** | Automação com scripts e parte dos testes automatizados | `scripts/desfazer.sh`, `scripts/estatisticas.sh`, `scripts/ajuda.sh`, `tests/test_estatistica.sh`, `tests/test_desfazer.sh`, `tests/test_ajuda.sh`, `tests/test_executar_tudo.sh` |
| **Jéssica Sobral** | Estrutura e lógica do sistema; Controle de versões (Git/GitHub); Gravação do vídeo (apresentação) | `organizador.sh` (menu principal), `Makefile`; criação e organização do repositório no GitHub, branches e Pull Requests; gravação do vídeo final |
| **Letícia Tchakerian** | Documentação e parte dos testes automatizados; Gravação do vídeo (apresentação) | `scripts/organizar.sh`, `README.md`, `tests/test_organizador.sh`; gravação do vídeo final |

## Uso de Inteligência Artificial como ferramenta de apoio

Durante o desenvolvimento deste projeto, o grupo utilizou IA's (Claude da Anthropic, Gemini do Google e o Chat GPT da OpenAI) como ferramenta de apoio, de forma similar ao uso de documentações, fóruns como Stack Overflow ou material de aula. O uso foi feito com responsabilidade, sempre com revisões e testes manuais realizados pelo grupo antes da entrega.

**Como as IA's foram utilizadas:**
- Apoio na estruturação inicial do projeto (organização de pastas e divisão em módulos/scripts);
- Geração de rascunhos de sequências de algoritimos para os scripts, posteriormente revisados, testados e ajustados pelo grupo;
- Sugestões de boas práticas em Shell Script (validação de parâmetros, tratamento de erros, uso de `while`/`for`/`if` de forma mais legível);
- Auxílio na explicação de comandos e conceitos durante o desenvolvimento, usado como material de estudo pelo grupo.

**O que o grupo fez por conta própria:**
- Definição do problema a ser resolvido e dos requisitos do sistema;
- Execução e criação de testes automatizados dos scripts em ambiente real;
- Criação e revisão linha a linha do código a partir dos algoritmos gerados, com ajustes e correções;
- Organização do repositório Git, commits individuais e divisão de tarefas entre os integrantes;
- Gravação e apresentação do vídeo mostrando o funcionamento do organizador.

O uso de IA seguiu a política da disciplina/instituição para uso de ferramentas de apoio ao aprendizado. Nenhum trecho de código foi utilizado sem compreensão do grupo sobre seu funcionamento.
