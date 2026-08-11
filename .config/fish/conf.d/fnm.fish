# fnm's --use-on-cd generator is verbose twice over: the generator itself applies
# the local version and announces it on stderr, and the hook it emits announces
# every later switch. --log-level error silences neither, and --log-level quiet
# would export FNM_LOGLEVEL=quiet, muting a manual `fnm use` as well. Owning the
# hook keeps automatic switches silent and manual ones verbose, at the cost of
# tracking fnm's version-file list ourselves.
fnm env --shell fish | source

function _fnm_autoload_hook --on-variable PWD --description 'Change Node version on directory change'
  status --is-command-substitution; and return
  if test -f .node-version -o -f .nvmrc -o -f package.json
    fnm use --silent-if-unchanged --log-level error
  end
end

# --use-on-cd applied the version once as a side effect of loading. The hook only
# fires on a later PWD change, so without this a shell opened inside a project
# keeps the default version.
_fnm_autoload_hook
