#!/bin/bash
cat movies.txt | sed -n '/review\/text:/p' | sed 's/review\/text: //g' > text.txt
