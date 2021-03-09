#! /usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
		print("log10.R - calculates log10 from an input matrix (adds 0.01 pseudocount)")
		print("Usage: Rscript log10.R input output")
		stop()
}

input = read.delim(args[1], header=T, comment.char="", row.names=1)
#print(head(input))
output = args[2]

input.log = log10(input+0.01)

rownames(input.log) = rownames(input)
colnames(input.log) = colnames(input)

write.table(input.log, file=output, sep="\t", quote=F)


