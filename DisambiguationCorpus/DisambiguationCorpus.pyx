from Corpus.Sentence cimport Sentence
from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse

from DisambiguationCorpus.DisambiguatedWord cimport DisambiguatedWord


cdef class DisambiguationCorpus(Corpus):

    def __init__(self, fileName=None):
        """
        Constructor which creates a list of sentences and a CounterHashMap of wordList.
        """
        cdef list lines
        cdef Sentence newSentence
        cdef str line, word, parse
        cdef DisambiguatedWord newWord
        super().__init__()
        if fileName is not None:
            inputFile = open(fileName, "r", encoding="utf8")
            lines = inputFile.readlines()
            newSentence = Sentence()
            for line in lines:
                word = line[:line.index("\t")]
                parse = line[line.index("\t") + 1:]
                if len(word) > 0 and len(parse) > 0:
                    newWord = DisambiguatedWord(word, MorphologicalParse(parse.strip()))
                    if word == "<S>":
                        newSentence = Sentence()
                    elif word == "</S>":
                        self.addSentence(newSentence)
                    elif word == "<DOC>" or word == "</DOC>" or word == "<TITLE>" or word == "</TITLE>":
                        pass
                    else:
                        newSentence.addWord(newWord)
            inputFile.close()

    cpdef writeToFile(self, str fileName):
        """
        The writeToFile method takes a str file name as an input and writes the elements of sentences list
        to this file with proper tags which indicates the beginnings and endings of the document and sentence.

        PARAMETERS
        ----------
        fileName : str
            File which will be filled with the sentences.
        """
        cdef Sentence sentence
        cdef DisambiguatedWord word
        outputFile = open(fileName, "w", encoding="utf8")
        outputFile.write("<DOC>\t<DOC>+BDTag\n")
        for sentence in self.sentences:
            outputFile.write("<S>\t<S>+BSTag\n")
            for word in sentence.words:
                if isinstance(word, DisambiguatedWord):
                    outputFile.write(word.getName() + "\t" + word.getParse().__str__() + "\n")
            outputFile.write("</S>\t</S>+ESTag\n")
        outputFile.write("</DOC>\t</DOC>+EDTag")
        outputFile.close()
