# The generated --use-on-cd hook runs `fnm use --silent-if-unchanged`, which still
# announces the version whenever it does switch. Drop it to `error` so automatic
# switches are silent while a manual `fnm use` stays verbose.
fnm env --use-on-cd --shell fish \
    | string replace -- \
        'fnm use --silent-if-unchanged' \
        'fnm use --silent-if-unchanged --log-level error' \
    | source
