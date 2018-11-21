library("ape")

#read tree
tree <- read.tree("OPT_mint_v2.tre")

#checking tree ultrametric or not
is.ultrametric(tree)

#plot tree without tip labels
plot.phylo(tree, show.tip.label = FALSE)

#adding x-axis
axisPhylo()
