vim.cmd([[
    function Setreg(regname, regval)
      exe "let @".a:regname." = '".a:regval."'"
    endfunction
    function CopyFullPath()
      let value = expand("%:p")
      call Setreg("*", value)
      call Setreg("+", value)
      echom "Yanked: " . value
    endfunction
    ]])
