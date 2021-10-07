# Defined via `source`
function em --wraps='emacsclient -nw' --description 'alias em emacsclient -nw'
  emacsclient -nw $argv; 
end
