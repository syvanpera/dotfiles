function myip --wraps='iconfig.co/json | jq -r .ip' --wraps='ifconfig.co/json | jq -r .ip' --wraps='http ifconfig.co/json | jq -r .ip' --wraps='http ifconfig.co/json | jq -r .ip | wl-copy' --wraps='http ifconfig.co -b | wl-copy' --wraps='curl ifconfig.co | wl-copy' --wraps='curl -q ifconfig.co | wl-copy' --wraps='curl -s ifconfig.co | wl-copy' --wraps='set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP' --description 'alias myip set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP'
  set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP $argv
        
end
