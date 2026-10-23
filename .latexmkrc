# Configuração do latexmk para a monografia.
# Uso: latexmk          (compila)
#      latexmk -c       (remove intermediários)
#      latexmk -pvc     (recompila ao salvar)

@default_files = ('monografia.tex');

# PDF via pdflatex, com mensagens de erro com arquivo:linha
$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S';

# Arquivos intermediários (.aux, .log, .bbl, .glo, ...) ficam em build/;
# o PDF final é gerado na raiz do projeto.
$aux_dir = 'build';
$out_dir = '.';
$emulate_aux = 1;

# Siglas/glossário (pacote glossaries com makeglossaries)
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
$clean_ext .= ' acr acn alg glo gls glg ist synctex.gz';

sub makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    my @args = ('-d', $path, $base_name);
    if ($silent) { unshift @args, '-q'; }
    return system 'makeglossaries', @args;
}
