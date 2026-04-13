" macros
let @r='8ldf.fr2df/4wcf/ismmdlk[f/xf#dE' " fmt @red comment url

" default actions for diff files
au BufWritePost /etc/nginx/*.conf !doas systemctl restart nginx
" curr does nothing bc not writeable by non-root user
au BufWritePost /usr/lib/systemd/system/*,/usr/local/lib/systemd/system/* !doas systemctl daemon-reload

ru dvorak.vim
