#!/bin/bash
paste -d , timestamp.txt helpful.txt score.txt text_count.txt summary_count.txt | sort -nrk 1 -t',' | uniq -u > combine.txt
