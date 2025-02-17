# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/wapl_ctcf/fountains
ATAC_CHIP_PATH=/DATA/users/magnitov/wapl_ctcf/chipseq
BLACKLIST=/DATA/users/magnitov/genomes/mm10-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/deeptools

computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -bs 5000 -a 1000000 -b 1000000 --missingDataAsZero --skipZeros \
	-S ${ATAC_CHIP_PATH}/ATACseq_CTCF_WAPL_0h.bw ${ATAC_CHIP_PATH}/ATACseq_CTCF_WAPL_24h.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_0h_H3K4me1.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_24h_H3K4me1.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_0h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_6h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_24h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_CTCF_WAPL_96h_RAD21.bw \
	-R ${INPUT_PATH}/plume_calls/fountains_fontanka_merged.bed -o ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_CW.gz

plotHeatmap -m ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_CW.gz -out ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_CW.pdf \
	--zMin 0 --zMax 3 3 0.8 0.8 0.6 0.6 0.6 0.6 --yMin 0 --yMax 3 3 0.8 0.8 0.6 0.6 0.6 0.6 --xAxisLabel "" --legendLocation none \
	--regionsLabel "Fountains (N=852)" --refPointLabel "" \
	--samplesLabel ATAC_0h ATAC_24h H3K4me1_0h H3K4me1_24h RAD21_0h RAD21_6h RAD21_24h RAD21_96h --colorMap Blues Blues RdPu RdPu Greys Greys Greys Greys --heatmapHeight 12 --heatmapWidth 3
    
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -bs 5000 -a 1000000 -b 1000000 --missingDataAsZero --skipZeros \
	-S ${ATAC_CHIP_PATH}/ATACseq_WAPL_0h.bw ${ATAC_CHIP_PATH}/ATACseq_WAPL_24h.bw ${ATAC_CHIP_PATH}/ChIPseq_WAPL_0h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_WAPL_6h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_WAPL_24h_RAD21.bw ${ATAC_CHIP_PATH}/ChIPseq_WAPL_96h_RAD21.bw \
	-R ${INPUT_PATH}/plume_calls/fountains_fontanka_merged.bed -o ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_W.gz

plotHeatmap -m ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_W.gz -out ${INPUT_PATH}/deeptools/ATACseq_ChIPseq_plumes_W.pdf \
	--zMin 0 --zMax 3 3 0.6 0.6 0.6 0.6 --yMin 0 --yMax 3 3 0.6 0.6 0.6 0.6 --xAxisLabel "" --legendLocation none \
	--regionsLabel "Fountains (N=852)" --refPointLabel "" \
	--samplesLabel ATAC_0h ATAC_24h RAD21_0h RAD21_6h RAD21_24h RAD21_96h --colorMap Blues Blues Greys Greys Greys Greys --heatmapHeight 12 --heatmapWidth 3
    
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -bs 5000 -a 1000000 -b 1000000 --missingDataAsZero --skipZeros \
	-S ${ATAC_CHIP_PATH}/public_data/bigwig/nora_2020.RAD21_untreated.spiked.bw ${ATAC_CHIP_PATH}/public_data/bigwig/nora_2020.RAD21_IAA_48H.spiked.bw \
	-R ${INPUT_PATH}/plume_calls/fountains_fontanka_merged.bed -o ${INPUT_PATH}/deeptools/ChIPseq_RAD21_CTCF_AID_plumes.gz

plotHeatmap -m ${INPUT_PATH}/deeptools/ChIPseq_RAD21_CTCF_AID_plumes.gz -out ${INPUT_PATH}/deeptools/ChIPseq_RAD21_CTCF_AID_plumes.pdf \
	--zMin 0 --zMax 0.4 --yMin 0 --yMax 0.4 --xAxisLabel "" --legendLocation none \
	--regionsLabel "Fountains (N=852)" --refPointLabel "" \
	--samplesLabel Untreated +IAA_48H --colorMap Greys Greys --heatmapHeight 12 --heatmapWidth 3
