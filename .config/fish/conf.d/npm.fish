set NPM_PACKAGES "$HOME/.npm-global"
if [ -d "$NPM_PACKAGES/bin" ]
  set PATH "$NPM_PACKAGES/bin" $PATH
end
