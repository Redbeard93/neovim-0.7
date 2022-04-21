"Avoid loading twice from autocommands
if exists("current_compiler")
    finish
endif
let current_compiler = "javac"

"Fallback compiler setlocal
if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=javac\ -g\ -d\ ./bin\ -cp\ \"lib/*\"\ $(find\ src\ -name\ \"*.java\")
CompilerSet errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
