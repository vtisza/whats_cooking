load("rf") #Pretrained random forest model
load("top_freq") #Frequency of ingredients in the cuisines
load("sparse") #Ingredients vectorspace
require(tm)
require(randomForest)
require(SnowballC)
require(wordcloud)
require(RColorBrewer)
suppressPackageStartupMessages(require(googleVis))

predict_func<-function(text){
  test_word<-Corpus(VectorSource(text))
  test_word <- tm_map(test_word, stemDocument)
  test_word <- tm_map(test_word, removePunctuation)
  dtmtest <- DocumentTermMatrix(test_word, control=list(weighting=weightTf, dictionary=Terms(sparse)))
  testDTM <- as.data.frame(as.matrix(dtmtest))
  result<-as.character(predict(rf, newdata = testDTM,type = "class"))
  result
}

wcloud<-function(pred){
  msk<-top_freq$cuisine==pred
  return(wordcloud(top_freq[msk,1],top_freq[msk,2],random.order = F, colors=brewer.pal(8,"Dark2"), random.color = F, max.words=50, scale = c(4,1), rot.per = .15))
}