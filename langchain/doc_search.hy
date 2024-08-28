(import langchain.text_splitter [CharacterTextSplitter])
(import langchain_community.vectorstores [Chroma])
(import langchain_openai.embeddings [OpenAIEmbeddings])
(import langchain_community.document_loaders [DirectoryLoader UnstructuredMarkdownLoader])
(import langchain.chains [VectorDBQA])
(import langchain_openai.llms [OpenAI])

(setv embeddings (OpenAIEmbeddings))

(setv loader (DirectoryLoader "./data/" :glob "**/*.txt" :loader_cls UnstructuredMarkdownLoader))
(setv documents (loader.load))
(print documents)

(setv
  text_splitter
  (CharacterTextSplitter :chunk_size 2500 :chunk_overlap 0))

(setv
  texts
  (text_splitter.split_documents documents))

(setv
  docsearch
  (Chroma.from_documents texts  embeddings))

(setv
  qa
  (VectorDBQA.from_chain_type
    :llm (OpenAI)
    :chain_type "stuff"
    :vectorstore docsearch))

(defn query [q]
  (print "Query: " q)
  (print "Answer: " (qa.run q)))

(query "What kinds of equipment are in a chemistry laboratory?")
(query "What is Austrian School of Economics?")
(query "Why do people engage in sports?")
(query "What is the effect of body chemistry on exercise?")
