#!/bin/bash
cat movies.txt | sed -n '/review\/summary:/p' | sed 's/review\/summary: //g' > summary.txt
