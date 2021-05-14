from Dictionary.Word cimport Word
from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse


cdef class DisambiguatedWord(Word):

    cdef MorphologicalParse __parse

    cpdef MorphologicalParse getParse(self)
