library(Matrix)
library(gamlr)
library(parallel)
library(distrom)
library(textir)
library(slam)
library(NLP)
library(rJava)
library(tm)

getwd()
setwd("C:/Users/user/Desktop/R_code")

stopwords<-c(stopwords("english"),scan(file="stopword.csv",what=" ",sep=""))

d.corpus <- Corpus(DirSource("C:/Users/user/Desktop/R_code/TEST_DATA"))
dtm = DocumentTermMatrix(d.corpus,control = list(wordLengths = c(3, 20),removeNumbers=TRUE,removePunctuation=TRUE,
                                                  stopwords=c(stopwords),weighting = function(x)weightTfIdf(x,normalize = TRUE)))

term=NULL
files<-list.files(path = "C:/Users/user/Desktop/R_code/TEST_DATA",pattern = '.txt')
for(file in files)
{
  temp=dtm[file,]
  Matrix <- as.matrix(temp)
  sortmatrix=sort(colSums(Matrix),decreasing=TRUE)[1:8]
  term=c(term,names(sortmatrix))
}
t=unique(term)
tfidf_matrix=matrix(c(0), nrow = NROW(files), ncol = NROW(t))
row.names(tfidf_matrix)=files
colnames(tfidf_matrix)=t

for(file in files)
{
  temp=dtm[file,]
  Matrix <- as.matrix(temp)
  sortmatrix=sort(colSums(Matrix),decreasing=TRUE)[1:8]
  sortmatrix=as.matrix(sortmatrix)
  tfidf_matrix[file, rownames(sortmatrix)]= d1[1,]
}

file_locat=paste("C:/Users/user/Desktop/R_code/tfidf.csv",seq="")
write.csv(tfidf_matrix,file_locat)
