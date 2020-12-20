from Dictionary.Trie.Trie cimport Trie
from Dictionary.TxtDictionary cimport TxtDictionary
from DataStructure.Cache.LRUCache cimport LRUCache
from Dictionary.TxtWord cimport TxtWord

from MorphologicalAnalysis.FsmParse cimport FsmParse
from MorphologicalAnalysis.FiniteStateMachine cimport FiniteStateMachine
from MorphologicalAnalysis.MetamorphicParse cimport MetamorphicParse
from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse


cdef class FsmMorphologicalAnalyzer:

    cdef Trie __dictionaryTrie
    cdef FiniteStateMachine __finiteStateMachine
    cdef TxtDictionary __dictionary
    cdef LRUCache __cache
    cdef dict __mostUsedPatterns
    cdef set __parsedSurfaceForms

    cpdef addParsedSurfaceForms(self, str fileName)
    cpdef set getPossibleWords(self, MorphologicalParse morphologicalParse, MetamorphicParse metamorphicParse)
    cpdef TxtDictionary getDictionary(self)
    cpdef FiniteStateMachine getFiniteStateMachine(self)
    cpdef bint __isPossibleSubstring(self, str shortString, str longString, TxtWord root)
    cpdef __initializeParseList(self, list fsmParse, TxtWord root, bint isProper)
    cpdef __initializeParseListFromRoot(self, list parseList, TxtWord root, bint isProper)
    cpdef list __initializeParseListFromSurfaceForm(self, str surfaceForm, bint isProper)
    cpdef __addNewParsesFromCurrentParse(self, FsmParse currentFsmParse, list fsmParse, maxLengthOrSurfaceForm,
                                       TxtWord root)
    cpdef bint __parseExists(self, list fsmParse, str surfaceForm)
    cpdef list __parseWord(self, list fsmParse, maxLengthOrSurfaceForm)
    cpdef list morphologicalAnalysisRoot(self, str surfaceForm, TxtWord root, state=*)
    cpdef list generateAllParses(self, TxtWord root, int maxLength)
    cpdef bint __analysisExists(self, TxtWord rootWord, str surfaceForm, bint isProper)
    cpdef list __analysis(self, str surfaceForm, bint isProper)
    cpdef bint patternMatches(self, str expr, str value)
    cpdef bint isProperNoun(self, str surfaceForm)
    cpdef morphologicalAnalysis(self, sentenceOrSurfaceForm)
    cpdef robustMorphologicalAnalysis(self, sentenceOrSurfaceForm)
    cpdef bint __isInteger(self, str surfaceForm)
    cpdef bint __isDouble(self, str surfaceForm)
    cpdef bint __isNumber(self, str surfaceForm)
    cpdef bint __isPercent(self, str surfaceForm)
    cpdef bint __isTime(self, str surfaceForm)
    cpdef bint __isRange(self, str surfaceForm)
    cpdef bint __isDate(self, str surfaceForm)
    cpdef str __toLower(self, str surfaceForm)
    cpdef bint morphologicalAnalysisExists(self, TxtWord rootWord, str surfaceForm)
