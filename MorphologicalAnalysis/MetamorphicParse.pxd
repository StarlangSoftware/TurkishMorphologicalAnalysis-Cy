from Dictionary.Word cimport Word

from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse


cdef class MetamorphicParse:

    cdef list __meta_morpheme_list
    cdef Word __root

    cpdef list getMetaMorphemeTag(self, str tag)
    cpdef Word getWord(self)
    cpdef list getMetaMorphemeTagForParse(self, MorphologicalParse parse, str tag)
    cpdef int size(self)
    cpdef addMetaMorphemeList(self, str newTacticSet)
    cpdef removeMetaMorphemeFromIndex(self, int index)
    cpdef str getMetaMorpheme(self, int index)
