#!/bin/bash
cat movies.txt | sed -n '/review\/helpfulness:/p' |  sed 's/review\/helpfulness: //g' > helpful.txt
