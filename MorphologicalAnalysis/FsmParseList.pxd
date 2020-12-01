from Dictionary.Word cimport Word
from MorphologicalAnalysis.FsmParse cimport FsmParse

cdef class FsmParseList:

    cdef list __fsmParses

    cpdef int size(self)
    cpdef addFsmParse(self, FsmParse fsmParse)
    cpdef FsmParse getFsmParse(self, int index)
    cpdef str rootWords(self)
    cpdef reduceToParsesWithSameRootAndPos(self, Word currentWithPos)
    cpdef FsmParse getParseWithLongestRootWord(self)
    cpdef reduceToParsesWithSameRoot(self, str currentRoot)
    cpdef list constructParseListForDifferentRootWithPos(self)
    cpdef str parsesWithoutPrefixAndSuffix(self)
