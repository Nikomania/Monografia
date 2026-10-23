# Monografia — Aplicativo de acessibilidade com uso de eye-tracking para comunicação #

Trabalho de conclusão de curso escrito em LaTeX com a classe `UnB-CIC`, modelo de formatação do [Departamento de Ciência da Computação](https://www.cic.unb.br) da [Universidade de Brasília](https://www.unb.br) (projeto original: [UnB-CIC/Monografia](https://github.com/UnB-CIC/Monografia)).


## Estrutura ##

| Caminho            | Conteúdo                                                        |
|--------------------|-----------------------------------------------------------------|
| `monografia.tex`   | Arquivo principal (dados do trabalho e lista de capítulos)      |
| `UnB-CIC.cls`      | Classe do documento — **evite** modificá-la                     |
| `tex/`             | Capítulos, resumo, abstract, siglas, apêndices e anexos         |
| `img/`             | Figuras                                                         |
| `doc/`             | PDFs incluídos no documento                                     |
| `bibliografia.bib` | Referências bibliográficas                                      |
| `.latexmkrc`       | Configuração de compilação (intermediários em `build/`)         |
| `build/`           | Arquivos intermediários gerados na compilação (não versionado)  |


## Instalação das dependências (Linux) ##

São necessários:

  * **TeX Live** com `pdflatex` e os pacotes usados pela classe (`babel`, `babelbib`, `glossaries`, `tracklang`, `boites`, `totalcount`, `hypcap`, `relsize`, `pdfpages`, …);
  * **`bibtex`** para as referências (estilo `babunsrt`, do pacote `babelbib`);
  * **`makeglossaries`** para a lista de siglas (script Perl, portanto é preciso ter `perl`);
  * **`latexmk`** para automatizar todo o processo.

Escolha o comando conforme a sua distribuição.

### Arch Linux / Manjaro ###

```bash
sudo pacman -S --needed perl \
    texlive-basic texlive-bin texlive-binextra texlive-latex \
    texlive-latexrecommended texlive-latexextra texlive-fontsrecommended \
    texlive-bibtexextra texlive-plaingeneric texlive-langportuguese
```

> `texlive-plaingeneric` fornece o `tracklang.sty`, exigido pelo `glossaries`. Sem ele a compilação falha com ``File `tracklang.sty' not found``.

### Debian / Ubuntu / Linux Mint ###

```bash
sudo apt update
sudo apt install perl latexmk \
    texlive-latex-base texlive-latex-recommended texlive-latex-extra \
    texlive-fonts-recommended texlive-bibtex-extra texlive-plain-generic \
    texlive-lang-portuguese
```

### Fedora ###

```bash
sudo dnf install perl latexmk \
    texlive-collection-latexrecommended texlive-collection-latexextra \
    texlive-collection-fontsrecommended texlive-collection-bibtexextra \
    texlive-collection-plaingeneric texlive-collection-langportuguese
```

### Qualquer distribuição (instalação completa) ###

Se preferir não se preocupar com pacotes individuais (ocupa alguns GB):

  * Arch: `sudo pacman -S texlive texlive-lang`
  * Debian/Ubuntu: `sudo apt install texlive-full`
  * Fedora: `sudo dnf install texlive-scheme-full`

Ou instale o TeX Live oficial seguindo o [guia do TUG](https://www.tug.org/texlive/quickinstall.html).

### Verificando a instalação ###

```bash
pdflatex --version
bibtex --version
makeglossaries --version
latexmk --version
kpsewhich tracklang.sty babunsrt.bst boites.sty totalcount.sty
```

Cada comando deve responder sem erro, e o `kpsewhich` deve imprimir um caminho para cada arquivo.


## Compilação do PDF ##

A compilação é feita pelo `latexmk`, que lê o arquivo `.latexmkrc` do projeto e executa automaticamente `pdflatex`, `bibtex` e `makeglossaries` quantas vezes forem necessárias.

```bash
cd /caminho/para/Monografia
latexmk
```

Resultado:

  * `monografia.pdf` — o documento final, na raiz do projeto;
  * `build/` — todos os arquivos intermediários (`.aux`, `.log`, `.bbl`, `.blg`, `.toc`, `.lof`, `.lot`, `.acn`, `.acr`, `.glo`, `.gls`, `.fls`, `.fdb_latexmk`, …). O diretório é criado automaticamente.

### Outros comandos úteis ###

```bash
latexmk -pvc     # recompila sempre que um arquivo .tex/.bib for salvo
latexmk -c       # remove os intermediários de build/ (mantém o PDF)
latexmk -C       # remove os intermediários e também o PDF
latexmk -g       # força a recompilação completa
rm -rf build/    # limpeza total, se algo ficar inconsistente
```

### Compilação manual (sem latexmk) ###

Caso não queira usar o `latexmk`, a sequência equivalente, mantendo os intermediários em `build/`, é:

```bash
mkdir -p build
pdflatex -output-directory=build monografia
BIBINPUTS=.: bibtex build/monografia
makeglossaries -d build monografia
pdflatex -output-directory=build monografia
pdflatex -output-directory=build monografia
cp build/monografia.pdf .
```

### Erros de compilação ###

A compilação para no primeiro erro (`-halt-on-error`) e mostra a mensagem no formato `arquivo:linha: erro`. O log completo fica em `build/monografia.log`.

  * ``File `xxx.sty' not found`` — falta um pacote do TeX Live. Descubra qual pacote da distribuição o fornece (por exemplo, `pacman -F xxx.sty` no Arch ou `apt-file search xxx.sty` no Debian/Ubuntu) e instale-o.
  * **Referências ou siglas não aparecem** — rode `latexmk -g` ou apague `build/` e compile de novo.
  * **Autores listados incorretamente nas referências** — no `.bib`, separe autores com `and`, nunca com `e`.


## Licença ##

O modelo `UnB-CIC` está licenciado sob a [Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional](http://creativecommons.org/licenses/by-sa/4.0/deed.pt_BR).
