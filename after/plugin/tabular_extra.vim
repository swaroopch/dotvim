
" :help Tabular.txt
if !exists(':Tabularize')
    finish
endif

AddTabularPattern first_equal /^[^=]*\zs=/
