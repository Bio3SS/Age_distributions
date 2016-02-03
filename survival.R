Survfun <- function(pmax, young, old, ages){
	p <- 1 + 0*ages
	if (!is.null(old)) p <- p*exp(-ages/old)
	if (!is.null(young)) p <- p*exp(-young/ages)
	return(p*pmax/max(p))
}

# We calculate L starting with a 1, and with the same length as p (don't pay attention survivors of the last age class for these pictures)
Lfun <- function(p){
	L <- 1
	for (i in 1:(length(p)-1)){
		L[i+1] <- L[i]*p[i]
	}
	return(L)
}

annplot <- function(x, p, title=""){
	par(cex=1.6)
	plot(x, p,
		xlab = "Age", ylab="Annual survival", type = "b",
		ylim = c(0, max(p)), 
		main=title
	)
}

cumplot <- function(x, L, logscale="y", title=""){
	par(cex=1.6)
	plot(x, L,
		xlab = "Age", ylab="Cumulative survival",
		type = "b", log=logscale, 
		main=title
	)
}

triplot <- function (pmax=0.5, young=NULL, old=NULL, ages=1:10,
	report="a", title=""){
	p <- Survfun(pmax, young, old, ages)
	L <- Lfun(p)
	data.frame(p=p, L=L)
	if((report=="a") | (report == "p")) annplot(ages, p, title=title)
	if((report=="a") | (report == "l")) cumplot(ages, L, title=title)
	if((report=="a") | (report == "L")) cumplot(ages, L, logscale="", title=title)
}

sadplot <- function(pmax=0.5, young=NULL, old=NULL, ages=1:10, lam=1, lamlabel=NULL){
	p <- Survfun(pmax, young, old, ages)
	L <- Lfun(p)
	sad <- L*lam^(-ages)
	sad <- sad/sum(sad)

	par(cex=1.2)
	barplot(sad, names.arg=ages,
		horiz=TRUE,
		density=7,
		xlab = "Proportion",
		ylab = "age",
		main="Stable age distribution",
	)
	if(is.null(lamlabel)){lamlabel <- mtext(paste("lambda =", lam))}
	mtext(lamlabel)
}

sadplot()

