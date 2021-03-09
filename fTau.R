#! /usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
		print("fTau.R - calculates fTau (a measure of tissue specificity) given a matrix of positive expression values")
		print("Usage: Rscript fTau.R input output")
		stop()
}

###+++###
#Functionrequire a vector with expression of one gene in different tissues.
#Ifexpression for one tissue is not known, gene specificity for this gene is NA
#Minimum2 tissues
fTau<- function(x) {
	if(all(!is.na(x))) {
		if(min(x, na.rm=TRUE) >= 0) {
			if(max(x)!=0) {
				x <- (1-(x/max(x)))
				res <- sum(x, na.rm=TRUE)
				res <- res/(length(x)-1)
			} else {
				res <- 0
			}
		} else {
			res <- NA
			print("Expression values have to be positive!")
		} 
	} else {
	res <- NA
	print("No data for this gene avalable.")
	} 
	return(res)
}


input = read.delim(args[1], header=T, comment.char="", row.names=1)
#print(head(input))
output = args[2]

ts = apply(input, 1, function(x) fTau(x))
maxTissue = colnames(input)[apply(input, 1, function(x) which(x == max(x))[1])]

towrite = cbind(ts, maxTissue)
rownames(towrite) = rownames(input)
colnames(towrite) = c("fTau", "maxTissue")

write.table(towrite, file=output, sep="\t", quote=F)


