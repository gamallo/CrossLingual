#!/bin/bash

L1=$1
L2=$2

gawk -v l1=`echo $L1`  '{print $1"#"l1, $2}' |
gawk -v l2=`echo $L2`  '{print $0"#"l2}' 

