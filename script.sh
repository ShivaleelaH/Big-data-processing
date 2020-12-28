#!/bin/sh
if [ "$1" != "" ]; then
    if [ $1 = "wordCount" ]; then
	hdfs dfs -rm -r -f /home/demopy/out_wc
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /home/cse587/wc_mapper.py -mapper /home/cse587/wc_mapper.py -file /home/cse587/wc_reducer.py -reducer /home/cse587/wc_reducer.py -input /home/demopy/gutenberg/ -output /home/demopy/out_wc/
	rm -rf out_wc
	hdfs dfs -copyToLocal /home/demopy/out_wc/ .

    elif [ $1 = "invertedIndex" ]; then
	hdfs dfs -rm -r -f /home/demopy/out_inv
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /home/cse587/inv_mapper.py -mapper /home/cse587/inv_mapper.py -file /home/cse587/inv_reducer.py -reducer /home/cse587/inv_reducer.py -input /home/demopy/gutenberg/ -output /home/demopy/out_inv/
	rm -rf out_inv
	hdfs dfs -copyToLocal /home/demopy/out_inv/ .

    elif [ $1 = "join" ]; then
	hdfs dfs -rm -r -f /home/demopy/out_join
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /home/cse587/join_mapper.py -mapper /home/cse587/join_mapper.py -file /home/cse587/join_reducer.py -reducer /home/cse587/join_reducer.py -input /home/demopy/join/*.csv -output /home/demopy/out_join/
	rm -rf out_join
	hdfs dfs -copyToLocal /home/demopy/out_join/ .

	elif [ $1 = "triGram" ]; then
	hdfs dfs -rm -r -f /home/demopy/out_tri
	hdfs dfs -rm -r -f /home/demopy/out_tri1
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /home/cse587/tri_mapper.py -mapper /home/cse587/tri_mapper.py -file /home/cse587/tri_reducer.py -reducer /home/cse587/tri_reducer.py -input /home/demopy/gutenberg/ -output /home/demopy/out_tri/ -jobconf mapred.reduce.tasks=3
	rm -rf out_tri
	hdfs dfs -copyToLocal /home/demopy/out_tri/ .
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /home/cse587/tri1_mapper.py -mapper /home/cse587/tri1_mapper.py -file /home/cse587/tri1_reducer.py -reducer /home/cse587/tri1_reducer.py -input /home/demopy/out_tri/ -output /home/demopy/out_tri1/
	rm -rf out_tri1
	hdfs dfs -copyToLocal /home/demopy/out_tri1/ .

	elif [ $1 ="knn"]; then
	hdfs dfs -rm -r -f /home/demopy/out_knn
	hadoop jar /home/cse587/hadoop-3.1.2/share/hadoop/tools/lib/hadoop-streaming-3.1.2.jar -file /Documents/knn_mapper.py -mapper /Documents/knn_mapper.py -file /Documents/knn_reducer.py -reducer /Documents/knn_reducer.py -input /knn/*.csv -output /home/demopy/out_knn/
    fi

else
    echo "Please enter 'wordCount' or 'invertedIndex' or 'join' or 'triGram' as argument"
fi


