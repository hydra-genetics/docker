

MELT kan laddas ner från: 
https://melt.igs.umaryland.edu/index.php

Den kan inte distribueras utanför akademisk användning, och inte laddas ner programmatiskt
Därför kan docker bilden inte delas offentligt

Output beskrivs här:
https://melt.igs.umaryland.edu/manual.php#_MELT_Output


Dockerfilen skapar en conda miljö med alla dependencies, och 
den kopierar en för-preparerad version av MELTv.2.2.2 som innehåller referensfiler som passar för docker-miljön 



Kör dockern med kommandot:

java -Xmx2G -jar MELT.jar Single  -w /MELT_references/Results_single_$sample -bamfile /MELT_references/$sample.bam -h /MELT_references/hg19.with.mt.fa -t /usr/bin/MELTv2.2.2/me_refs/1KGP_Hg19/mei_list.txt -n /usr/bin/MELTv2.2.2/add_bed_files/1KGP_Hg19/hg19.genes.bed

genom fasta filen (-h) ska vara samma fil som din sample.bam har alignats mot. 
genom fasta filen (-h) ska också ha en .fai fasta index
transposon-referenserna (-t) innehåller full paths till referensfiler som kommer med MELT, och som innehåller olika klasser av transposoner
gene bed (-n) är en fil som innehåller gen-koordinater för genomet du jobbar med

MELT.jar Single mode gör flera steg av att indexa BAM-filen, analysera och skapa ut-filer i mappen (-w) 


Resultat-filerna du behöver mest är:

BAM filerna: *merged.hum_breaks.sorted.bam*
VCF-filerna: *final_comp.vcf 

VCF-filerna kan behöva filtreras, eftersom dom innehåller både säkra och mindre säkra hits





