au BufRead,BufNewFile .env.*            setfiletype sh
au BufRead,BufNewFile *.mjml            setfiletype html
au BufRead,BufNewFile .commitlintrc     setfiletype jsonc
au BufRead,BufNewFile .czrc             setfiletype jsonc
au BufRead,BufNewFile .importsortrc     setfiletype jsonc
au BufRead,BufNewFile .lintstagedrc     setfiletype jsonc
au BufRead,BufNewFile .releaserc        setfiletype jsonc
au BufRead,BufNewFile .syncpackrc       setfiletype jsonc
au BufRead,BufNewFile Appfile           setfiletype ruby
au BufRead,BufNewFile Fastfile          setfiletype ruby
au BufRead,BufNewFile Matchfile         setfiletype ruby
au BufRead,BufNewFile Pipfile           setfiletype toml

" this is a workaround for https://github.com/neovim/nvim-lspconfig/issues/2685
au BufRead,BufNewFile *.tfvars          setfiletype terraform
