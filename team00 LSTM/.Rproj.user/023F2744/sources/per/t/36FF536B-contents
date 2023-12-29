# install.packages('tidytext')
# install.packages('keras')
#install.packages('tidyverse')
library(dplyr)
library(tidyverse) # importing, cleaning, visualising 
library(tidytext) # working with text
library(keras) # deep learning with keras
library(data.table) # fast csv reading

train <- fread('C:/k_digital/data/LSTM/train.csv', data.table = FALSE)
test <- fread('C:/k_digital/data/LSTM/test.csv', data.table = FALSE)

test %>% head()

train %>% filter(target == 1) %>% sample_n(5)

# Setup some parameters

max_words <- 15000 # Maximum number of words to consider as features
maxlen <- 64 # Text cutoff after n words


# Prepare to tokenize the text

full <- rbind(train %>% select(question_text), test %>% select(question_text))
texts <- full$question_text

tokenizer <- text_tokenizer(num_words = max_words) %>% 
  fit_text_tokenizer(texts)

# Tokenize - i.e. convert text into a sequence of integers

sequences <- texts_to_sequences(tokenizer, texts)
word_index <- tokenizer$word_index

# Pad out texts so everything is the same length

data = pad_sequences(sequences, maxlen = maxlen)

# 파이썬 오류
install.packages('reticulate')
library(reticulate)
reticulate::conda_list()

Sys.setenv(RETICULATE_PYTHON = paste(miniconda_path(),"/python.exe", sep = ""))
py_install(as.list(strsplit("dill numpy pandas pmdarima torch nowcast-lstm", " ")[[1]]), pip = TRUE, conda = conda_binary())
initialize_session(paste(miniconda_path(),"/python.exe", sep = "")) 

devtools::install_github('rstudio/tensorflow')
