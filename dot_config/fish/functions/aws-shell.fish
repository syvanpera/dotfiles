function aws-shell --wraps='nix develop ~/projects/nix-shells/aws' --description 'alias aws-shell nix develop ~/projects/nix-shells/aws'
  nix develop ~/projects/nix-shells/aws $argv
        
end
