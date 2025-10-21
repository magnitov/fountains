library('regioneR')

genome <- getGenome("mm10")

plume_anchors <- read.table(paste('fountains_fontanka_merged.bed', sep=""), header = FALSE)
plume_anchors <- GRanges(seqnames = plume_anchors$V1, ranges = IRanges(start = plume_anchors$V2, end = plume_anchors$V3))
ctcf_peaks <- read.table('mESC_chromHMM.bed', header = FALSE)
  
fc_anchors <- c()

for (state in c("1_Insulator", "2_Intergenic", "3_Heterochromatin", "4_Enhancer", "5_RepressedChromatin", "6_BivalentChromatin",
                "7_ActivePromoter", "8_StrongEnhancer", "9_TranscriptionTransition", "10_TranscriptionElongation", "11_WeakEnhancer")) {
    chromHMM_state <- GRanges(seqnames = chromHMM[chromHMM$V4 == state, ]$V1, 
                              ranges = IRanges(start = chromHMM[chromHMM$V4 == state, ]$V2, end = chromHMM[chromHMM$V4 == state, ]$V3))
    
    test_anchors <- permTest(A=plume_anchors, B=chromHMM_state, randomize.function = circularRandomizeRegions, 
                             evaluate.function = numOverlaps, ntimes=10, genome=genome, verbose=TRUE)
    
    fc_anchors <- append(fc_anchors, test_anchors$numOverlaps$observed / mean(test_anchors$numOverlaps$permuted))
}

test_results <- as.data.frame(do.call(cbind, list(c("1_Insulator", "2_Intergenic", "3_Heterochromatin", "4_Enhancer", 
                                                    "5_RepressedChromatin", "6_BivalentChromatin", "7_ActivePromoter", 
                                                    "8_StrongEnhancer", "9_TranscriptionTransition", 
                                                    "10_TranscriptionElongation", "11_WeakEnhancer"),
                                                    fc_anchors)))
write.csv(test_results, paste('chromhmm_merged.csv', sep = ""), row.names = FALSE)


