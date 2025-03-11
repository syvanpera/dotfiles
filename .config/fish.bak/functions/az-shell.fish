function az-shell --wraps='nix develop ~/projects/nix-shells/azure' --description 'alias az-shell nix develop ~/projects/nix-shells/azure'
  nix develop ~/projects/nix-shells/azure $argv
        
end
