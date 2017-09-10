#!/bin/bash

#python3 dump_revisions.py /export/scratch/kangjing/projects/wiki_bots/data/enwiki-20170701-pages-meta-history1.xml-p9655p11642.bz2 /export/scratch/kangjing/projects/wiki_bots/data/out.txt data/bot.txt

declare -a FILES
readarray -t FILES < ../data/urls_page_current_20170701.txt

BASEURL="https://dumps.wikimedia.org/enwiki/20170701/"
TMPDIR="/export/scratch/kangjing/fkj/kangjing/projects/wiki_bots/data/tmp/"
TMPDIR="/export/scratch/kangjing/fkj/kangjing/projects/wiki_bots/data/raw_current_page_20170701/"
OUTDIR="/export/scratch/kangjing/fkj/kangjing/projects/wiki_bots/data/parsed_data/"
WPDIR="/export/scratch/kangjing/fkj/kangjing/projects/wiki_bots/data/parsed_data_20170701/parsed_files_wp2/"
CATDIR="/export/scratch/kangjing/fkj/kangjing/projects/wiki_bots/data/parsed_data_20170701/parsed_files_cat2/"


#readarray -t FILES < ../data/urls_page_current_20170620.txt

#BASEURL="http://dumps.wikimedia.org/enwiki/20170620/"
#TMPDIR="/scratch/kangjing/projects/wiki_bots/data/tmp/"
#OUTDIR="/scratch/kangjing/projects/wiki_bots/data/parsed_data/"
#WPDIR="/scratch/kangjing/projects/wiki_bots/data/parsed_data_20170620/parsed_files_wp/"
#CATDIR="/scratch/kangjing/projects/wiki_bots/data/parsed_data_20170620/parsed_files_cat/"

FILENAME="parsed_file_page_current_"
FILETYPE=".json"

start=$SECONDS
declare -r cont=12

let i=0
echo ${#FILES[@]}
while (( i < ${#FILES[@]} )); do
    #if [ "$i" -le 50 ]
    #then
    #    ((++i))
    #    continue
    #fi
    echo "NO.$i Processing ${FILES[i]}"
    wget -P "$TMPDIR" -c "$BASEURL${FILES[i]}"
    echo "$TMPDIR${FILES[i]}"
    python3 dump_revisions.py "$TMPDIR${FILES[i]}" "$FILENAME${i}$FILETYPE" data/bot.txt
    rm -f "$TMPDIR${FILES[i]}"
    ((++i))
done


duration=$((( $SECONDS-$start ) / 3600))
echo "Program duration $duration"
