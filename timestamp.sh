#!/bin/bash
cat movies.txt | sed -n '/review\/time:/p' | sed 's/review\/time: //g' > timestamp.txt
