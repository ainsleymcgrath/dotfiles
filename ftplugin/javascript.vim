set shiftwidth=2

function! PrettyFile()
  if &filetype=="javascript"
    if exists('g:loaded_Beautifier')
      call JsBeautify()
    endif
    if exists('g:loaded_ESLintFix')
      call ESLintFix()
    endif
  end
endfunction

noremap <Leader>fo :PrettierAsync<cr>
