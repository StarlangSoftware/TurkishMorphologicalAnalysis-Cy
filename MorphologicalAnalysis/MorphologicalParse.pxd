from Dictionary.Word cimport Word

from MorphologicalAnalysis.InflectionalGroup cimport InflectionalGroup
from MorphologicalAnalysis.MorphologicalTag import MorphologicalTag


cdef class MorphologicalParse:

    cdef list inflectionalGroups
    cdef Word root

    cpdef Word getWord(self)
    cpdef str getTransitionList(self)
    cpdef str getInflectionalGroupString(self, int index)
    cpdef InflectionalGroup getInflectionalGroup(self, int index)
    cpdef InflectionalGroup getLastInflectionalGroup(self)
    cpdef str getTag(self, int index)
    cpdef int tagSize(self)
    cpdef int size(self)
    cpdef InflectionalGroup firstInflectionalGroup(self)
    cpdef InflectionalGroup lastInflectionalGroup(self)
    cpdef Word getWordWithPos(self)
    cpdef str getPos(self)
    cpdef str getRootPos(self)
    cpdef str lastIGContainsCase(self)
    cpdef bint lastIGContainsTag(self, object tag)
    cpdef bint lastIGContainsPossessive(self)
    cpdef bint isCapitalWord(self)
    cpdef bint isNoun(self)
    cpdef bint isVerb(self)
    cpdef bint isRootVerb(self)
    cpdef bint isAdjective(self)
    cpdef bint isProperNoun(self)
    cpdef bint isPunctuation(self)
    cpdef bint isCardinal(self)
    cpdef bint isOrdinal(self)
    cpdef bint isReal(self)
    cpdef bint isNumber(self)
    cpdef bint isTime(self)
    cpdef bint isDate(self)
    cpdef bint isHashTag(self)
    cpdef bint isEmail(self)
    cpdef bint isPercent(self)
    cpdef bint isFraction(self)
    cpdef bint isRange(self)
    cpdef bint isPlural(self)
    cpdef bint isAuxiliary(self)
    cpdef bint containsTag(self, object tag)
    cpdef str getTreePos(self)
