# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/wapl_ctcf/fountains
DAMID_PATH=/DATA/users/magnitov/wapl_ctcf/damid
BLACKLIST=/DATA/users/magnitov/genomes/mm10-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/deeptools

computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -bs 10000 -a 1000000 -b 1000000 --missingDataAsZero --skipZeros \
	-S ${DAMID_PATH}/pA_DamID_CTCF_WAPL_0h.bw ${DAMID_PATH}/pA_DamID_CTCF_WAPL_6h.bw ${DAMID_PATH}/pA_DamID_CTCF_WAPL_24h.bw ${DAMID_PATH}/pA_DamID_CTCF_WAPL_96h.bw \
	-R ${INPUT_PATH}/plume_calls/fountains_fontanka_merged.bed -o ${INPUT_PATH}/deeptools/pA_DamID_plumes.gz

plotHeatmap -m ${INPUT_PATH}/deeptools/pA_DamID_plumes.gz -out ${INPUT_PATH}/deeptools/pA_DamID_plumes.pdf \
	--zMin -2 --zMax 2 --yMin -1.5 --yMax 1.5 --xAxisLabel "" --legendLocation none \
	--regionsLabel "Fountains (N=852)" --refPointLabel "" \
	--samplesLabel CTCF_WAPL_0h CTCF_WAPL_6h CTCF_WAPL_24h CTCF_WAPL_96h --colorMap RdBu --heatmapHeight 12 --heatmapWidth 3