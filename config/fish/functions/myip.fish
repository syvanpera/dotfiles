function myip --wraps='set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP' --description 'alias myip set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP'
  set IP (curl -s ifconfig.co) && echo $IP && wl-copy $IP $argv
        
end
