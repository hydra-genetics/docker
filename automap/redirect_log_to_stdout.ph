--- AutoMap_v1.2.sh.old	2023-02-17 11:37:54.234262165 +0100
+++ AutoMap_v1.2.sh	2023-02-17 11:40:06.700724349 +0100
@@ -266,7 +266,7 @@
         multivcf3
     fi
 
-    nb="$(bcftools query -l $vcf 2> $here/.log | wc -l | cut -d" " -f1 )"
+    nb="$(bcftools query -l $vcf 2> /dev/stdout | wc -l | cut -d" " -f1 )"
 
     for (( k=0; k<$nb; k++ ))
     do
@@ -306,10 +306,10 @@
 
         nbvar=$(grep -v "#" $vcf | grep -P "AD|DP4|AO" | grep GT | wc -l)
 
-        nb="$(bcftools query -l $vcf 2> $here/.log | wc -l | cut -d" " -f1 )"
+        nb="$(bcftools query -l $vcf 2> /dev/stdout | wc -l | cut -d" " -f1 )"
         if [ "$nb" == "1" ]; then
             if [ -z "${id}" ]; then
-                id="$(bcftools query -l $vcf 2> $here/.log)"
+                id="$(bcftools query -l $vcf 2> /dev/stdout)"
                 if [ "$k" == "0" ]; then
                     allid=$id
                 fi
@@ -366,7 +366,7 @@
         if [ -s $out/$id/$id.clean.tsv ]; then
             :
         else 
-            perl $here/Scripts/parse_vcf_v1.1.pl $out/$id/$id.tsv $out/$id/$id.clean.tsv 2> $here/.log
+            perl $here/Scripts/parse_vcf_v1.1.pl $out/$id/$id.tsv $out/$id/$id.clean.tsv 2> /dev/stdout
             rm $out/$id/$id.tsv
         fi
 
@@ -389,7 +389,7 @@
         input=$out/$id/$id.clean.qual.sort.tsv
         output_path=$out/$id
         output=$output_path/$id.HomRegions
-        perl $here/Scripts/homo_regions.pl $input $output $panel $panelname $window $windowthres $here/Scripts/trimming.sh $maxgap $here/Scripts/extend.sh $extend 2> $here/.log
+        perl $here/Scripts/homo_regions.pl $input $output $panel $panelname $window $windowthres $here/Scripts/trimming.sh $maxgap $here/Scripts/extend.sh $extend 2> /dev/stdout
 
         echo 
         echo "3) Filtering of regions found and output to text file"
@@ -455,12 +455,12 @@
         outputR=$output
         if [ "$chrx" == "Yes" ]; then
             
-            Rscript $here/Scripts/make_graph_chrX.R $id $output.tsv $outputR.pdf $size 2> $here/.log
+            Rscript $here/Scripts/make_graph_chrX.R $id $output.tsv $outputR.pdf $size 2> /dev/stdout
         else
-            Rscript $here/Scripts/make_graph.R $id $output.tsv $outputR.pdf $size 2> $here/.log
+            Rscript $here/Scripts/make_graph.R $id $output.tsv $outputR.pdf $size 2> /dev/stdout
         fi
 
-        rm -f $out/$id/$id.clean* $out/$id/$id.HomRegions.homozygosity* $here/.log $vcf.chr
+        rm -f $out/$id/$id.clean* $out/$id/$id.HomRegions.homozygosity* $vcf.chr
     done
 
     # Regions common to all
@@ -487,4 +487,4 @@
     fi
 fi
 
-rm -f $here/.log
+
