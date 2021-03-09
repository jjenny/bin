#! /usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
		print("normTpm.R - normalizes a matrix of TPM values using calcNormFactors() from edgeR. Requires edgeR package.")
		print("Usage: Rscript normTpm.R input output")
		stop()
}

library(edgeR)

input = read.delim(args[1], header=T, comment.char="", row.names=1)
#print(head(input))
output = args[2]

#normalize data
scale = calcNormFactors(input)
print("scale factors:")
print(scale)
input.norm = input / scale

rownames(input.norm) = rownames(input)
colnames(input.norm) = colnames(input)

write.table(input.norm, file=output, sep="\t", quote=F)


