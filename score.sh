#!/bin/bash
cat movies.txt | sed -n '/review\/score:/p' | tr -d 'review/score: ' > score.txt
