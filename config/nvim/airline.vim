" vim-airline config
function! AirlineInit()
  let g:airline_section_z = ""
endfunction
autocmd VimEnter * call AirlineInit()
