function lazyvim --wraps='NVIM_APPNAME=lazyvim nvim' --wraps='NVIM_APPNAME=lazyvim ./nvim.appimage' --wraps='NVIM_APPNAME=lazyvim ~/apps/nvim.appimage' --description 'alias lazyvim NVIM_APPNAME=lazyvim nvim'
  NVIM_APPNAME=lazyvim nvim $argv
        
end
