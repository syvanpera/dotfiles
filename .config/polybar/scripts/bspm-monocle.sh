#!/bin/bash

bspm monocle --subscribe-node-count | while read -r n_nodes; do
	if [[ $n_nodes == "-1" ]]
	then
		echo ""
	else
		echo "$n_nodes"
	fi
done
