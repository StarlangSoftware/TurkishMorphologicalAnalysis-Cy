from Corpus.Corpus cimport Corpus


cdef class DisambiguationCorpus(Corpus):

    cpdef writeToFile(self, str fileName)
