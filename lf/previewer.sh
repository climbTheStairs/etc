#!/bin/sh
# dep: bat, chafa, tar, unzip
readonly BS=$(printf \\b)
f=$1 w=$(($2 - 5)) h=$3
case $f in
	*.tsv)							tsv.py < "$f" ;;
	*.jpg|*.png|*.svg|*.webp)		chafa --size "${w}x${h}" "$f" ;;
	*.mp[34]|*.m4[av]|*.mkv|*.webm)	mediainfo "$f" ;;
	*.pdf)							pdftotext "$f" - ;;
	*.docx)							pandoc "$f" --to markdown --columns "$w" ;;
	*.tar)							tar -tvf "$f" ;;
# TODO: mor gen xz, o0 compressn
	*.tar.gz|*.tgz)					tar -tvzf "$f" ;;
	*.tar.xz|*.txz)					tar -tvJf "$f" ;;
	*.zip)							unzip -l "$f" ;;
	#*.dv)							dvcode < "$f" ;;
	*.json)							jq --color-output < "$f" ;;
	*.[123456789]|*.[123456789p])	man -O "width=$w" "$f" | sed "s/.$BS"'\(.\)/\1/g' ;;
	*.c|*.cpp|*.css|*.go|*.h|*.java|*.js|*.lua|*.html|*.py|*.sh|[Mm]akefile) # TODO: `*Makefile`?
									highlight -O ansi "$f" ;;
	*)
		if [ "$(head -n 1 "$f" | cut -c 1-2)" = '#!' ]; then
			highlight -O ansi "$f"
		else
			bat --force-colorization --wrap never --terminal-width "$w" "$f"
			# https://github.com/gokcehan/lf/issues/534#issuecomment-2039527648
			# fold -sw $(($2 - 2)) "$1"
		fi
		;;
esac
