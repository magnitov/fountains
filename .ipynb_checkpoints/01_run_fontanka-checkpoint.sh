INPUT_PATH=/DATA/users/magnitov/wapl_ctcf/fountains
HIC_MAPS_PATH=/DATA/users/magnitov/wapl_ctcf/contact_maps

mkdir -p ${INPUT_PATH}/plume_calls/expected/
mkdir -p ${INPUT_PATH}/plume_calls/snips/
mkdir -p ${INPUT_PATH}/plume_calls/fountains/

### Define the parameters:
NTHREADS=20
RESOLUTION=20000
FLANK=1000000
MASK_PLUMES="${INPUT_PATH}/masks/average_plume.npy"

for SAMPLE in WAPL_CTCF_merged_6h_24h WAPL_CTCF_6h WAPL_CTCF_24h
do
	### Calculate expected
	cooltools expected-cis ${HIC_MAPS_PATH}/${SAMPLE}.mcool::resolutions/${RESOLUTION} \
		--view ${INPUT_PATH}/plume_calls/mm10.arms.viewframe.tsv \
		-p $NTHREADS --clr-weight-name weight --ignore-diags 2 \
		-o ${INPUT_PATH}/plume_calls/expected/${SAMPLE}.expected.tsv

	### Snip the genome
	fontanka slice-windows ${HIC_MAPS_PATH}/${SAMPLE}.mcool::resolutions/${RESOLUTION} \
		${INPUT_PATH}/plume_calls/snips/${SAMPLE}.snips.npy \
		-p $NTHREADS -W ${FLANK} \
		--view ${INPUT_PATH}/plume_calls/mm10.arms.viewframe.tsv --expected ${INPUT_PATH}/plume_calls/expected/${SAMPLE}.expected.tsv

	### Call the fountains with manual mask
	fontanka apply-fountain-mask ${HIC_MAPS_PATH}/${SAMPLE}.mcool::resolutions/${RESOLUTION} \
		${INPUT_PATH}/plume_calls/fountains/${SAMPLE}.fontanka.plumes.output.tsv \
		--snips ${INPUT_PATH}/plume_calls/snips/${SAMPLE}.snips.npy \
		-W ${FLANK} -M ${MASK_PLUMES} \
		--view ${INPUT_PATH}/plume_calls/mm10.arms.viewframe.tsv
done