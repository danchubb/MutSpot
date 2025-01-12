#' Mutation hotspot recurrence prediction for indel.
#' 
#' @param mask.regions.file Regions to mask in genome, for example, non-mappable regions/immunoglobin loci/CDS regions RDS file, default file = mask_regions.RDS.
#' @param continuous.features.selected.indel.url.file Text file containing URLs of indel continuous features selected for model.
#' @param discrete.features.selected.indel.url.file Text file containing URLs of indel discrete features selected for model.
#' @param sample.specific.features.url.file Text file containing URLs of sample specific features, default = NULL.
#' @param indel.mutations.file Indel mutations found in region of interest MAF file.
#' @param indel.mutations.file2 Indel mutations MAF file.
#' @param indel.model.file Indel model.
#' @param region.of.interest Region of interest bed file, default = NULL.
#' @param cores Number of cores, default = 1.
#' @param min.count Minimum number of mutated samples in each hotspot, default = 2.
#' @param hotspot.size Size of each hotspot, default = 21.
#' @param genome.size Total number of hotspots to run analysis on, default = 2533374732.
#' @param hotspots To run hotspot analysis or region-based analysis, default = TRUE.
#' @param merge.hotspots To plot overlapping hotspots as 1 hotspot or individual hotspots, default = TRUE.
#' @param output.dir Save plot in given output directory.
#' @param fdr.cutoff FDR cutoff, default = 0.1.
#' @param color.line Color given FDR cutoff, default = red.
#' @param color.dots Color hotspots that passed given FDR cutoff, default = maroon1.
#' @param color.muts Color points, default = orange.
#' @param top.no Number of top hotspots to plot, default = 3.
#' @param promoter.file Promoter regions bed file, default file = Ensembl75.promoters.coding.bed.
#' @param utr3.file 3'UTR regions bed file, default file = Ensembl75.3UTR.coding.bed.
#' @param utr5.file 5'UTR regions bed file, default file = Ensembl75.5UTR.coding.bed.
#' @param other.annotations Text file containing URLs of additional regions to be annotated, default = NULL.
#' @param debug To delete temporary files or not, default = FALSE.
#' @return Dataframe containing predicted hotspots significance with hotspots information for indel/merged/annotated and hotspots manhattan and top hits figures.
#' @export

mutPredict.indel = function(mask.regions.file = system.file("extdata", "mask_regions.RDS", package = "MutSpot"), continuous.features.selected.indel.url.file, discrete.features.selected.indel.url.file, sample.specific.features.url.file = NULL, indel.mutations.file, indel.mutations.file2, indel.model.file, region.of.interest, cores = 1, min.count = 2, hotspot.size = 21, genome.size = 2533374732, hotspots = TRUE, merge.hotspots = TRUE, output.dir,
                            fdr.cutoff = 0.1, color.line = "red", color.dots = "maroon1", color.muts ="orange", top.no = 3,
                            promoter.file = system.file("extdata", "Ensembl75.promoters.coding.bed", package = "MutSpot"),
                            utr3.file = system.file("extdata", "Ensembl75.3UTR.coding.bed", package = "MutSpot"), 
                            utr5.file = system.file("extdata", "Ensembl75.5UTR.coding.bed", package = "MutSpot"), 
                            other.annotations = NULL, debug = FALSE) {

  mutPredict.indel.prepare(mask.regions.file = mask.regions.file, continuous.features.selected.indel.url.file = continuous.features.selected.indel.url.file,
                           discrete.features.selected.indel.url.file = discrete.features.selected.indel.url.file, sample.specific.features.url.file = sample.specific.features.url.file,
                           indel.mutations.file = indel.mutations.file, indel.mutations.file2 = indel.mutations.file2, indel.model.file = indel.model.file,
                           region.of.interest = region.of.interest, cores = cores, min.count = min.count, hotspot.size = hotspot.size,
                           genome.size = genome.size, hotspots = hotspots, output.dir = output.dir)
  
  return(mutPredict.indel.run.lr(output.dir = output.dir, merge.hotspots = merge.hotspots, indel.mutations.file = indel.mutations.file,
                                 fdr.cutoff = fdr.cutoff, color.line = color.line, color.dots = color.dots, color.muts = color.muts,
                                 top.no = top.no, promoter.file = promoter.file, utr3.file = utr3.file, 
                                 utr5.file = utr5.file, other.annotations = other.annotations, debug = debug, cores = cores))

}
