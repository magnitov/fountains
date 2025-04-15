INPUT_PATH=/DATA/users/magnitov/wapl_ctcf/
MSIGDB_PATH=/DATA/users/magnitov/znf143/
GSEA=/DATA/users/magnitov/software/GSEA_Linux_4.3.2/gsea-cli.sh

for SAMPLE in CW_6H CW_24H CW_48H CW_96H RAD21_6H RAD21_24H
do
#	# Hallmarks
	${GSEA} GSEAPreranked -gmx ${MSIGDB_PATH}/genome/msigdb_mouse/mh.all.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq/gsea/genes_${SAMPLE}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label Hallmarks_${SAMPLE} -out ${INPUT_PATH}/rnaseq/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false

	# GO terms
	${GSEA} GSEAPreranked -gmx ${MSIGDB_PATH}/genome/msigdb_mouse/m5.go.bp.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq/gsea/genes_${SAMPLE}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_BP_${SAMPLE} -out ${INPUT_PATH}/rnaseq/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false
	${GSEA} GSEAPreranked -gmx ${MSIGDB_PATH}/genome/msigdb_mouse/m5.go.mf.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq/gsea/genes_${SAMPLE}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_MF_${SAMPLE} -out ${INPUT_PATH}/rnaseq/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false
	${GSEA} GSEAPreranked -gmx ${MSIGDB_PATH}/genome/msigdb_mouse/m5.go.cc.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq/gsea/genes_${SAMPLE}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label GO_CC_${SAMPLE} -out ${INPUT_PATH}/rnaseq/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false

	# Pathways
	${GSEA} GSEAPreranked -gmx ${MSIGDB_PATH}/genome/msigdb_mouse/m2.cp.reactome.v2023.2.Mm.symbols.gmt -rnk ${INPUT_PATH}/rnaseq/gsea/genes_${SAMPLE}.ranked.rnk \
		-set_max 1000000 -set_min 0 -rpt_label Canonical_pathways_${SAMPLE} -out ${INPUT_PATH}/rnaseq/gsea/ \
		-collapse No_Collapse -mode Max_probe -norm meandiv -nperm 10000 -scoring_scheme weighted \
		-create_svgs true -include_only_symbols true -make_sets true -plot_top_x 25 -rnd_seed timestamp -zip_report false
done
