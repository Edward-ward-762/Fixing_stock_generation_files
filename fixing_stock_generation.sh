##UPDATE PIPELINE
nextflow pull Edward-ward-762/Fixing_stock_generation_files -r main

##RUN PIPELINE
nextflow run Edward-ward-762/Fixing_stock_generation_files \
-r main \
-profile docker \
-resume \
--inputFile ./inputFile.csv 