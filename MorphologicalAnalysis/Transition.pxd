from Dictionary.TxtWord cimport TxtWord
from MorphologicalAnalysis.FsmParse cimport FsmParse
from MorphologicalAnalysis.State cimport State


cdef class Transition:

    cdef State __to_state
    cdef str __with, __with_name, __to_pos

    cpdef State toState(self)
    cpdef str toPos(self)
    cpdef bint transitionPossibleForString(self, str currentSurfaceForm, str realSurfaceForm)
    cpdef bint transitionPossibleForParse(self, FsmParse currentFsmParse)
    cpdef bint transitionPossibleForWord(self, TxtWord root, State fromState)
    cpdef str __withFirstChar(self)
    cpdef bint __startWithVowelorConsonantDrops(self)
    cpdef bint softenDuringSuffixation(self, TxtWord root, State startState)
    cpdef str makeTransitionNoStartState(self, TxtWord root, str stem)
    cpdef str makeTransition(self, TxtWord root, str stem, State startState)
    cpdef str withName(self)
