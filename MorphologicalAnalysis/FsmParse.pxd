from MorphologicalAnalysis.MorphologicalParse cimport MorphologicalParse
from MorphologicalAnalysis.State cimport State


cdef class FsmParse(MorphologicalParse):

    cdef list __suffix_list
    cdef list __form_list
    cdef list __transition_list
    cdef list __with_list
    cdef str __initial_pos, __pos, __form, __verb_agreement, __possesive_agreement

    cpdef constructInflectionalGroups(self)
    cpdef str getVerbAgreement(self)
    cpdef str getPossesiveAgreement(self)
    cpdef setAgreement(self, str transitionName)
    cpdef str getLastLemmaWithTag(self, str pos)
    cpdef str getLastLemma(self)
    cpdef addSuffix(self, State suffix, str form, str transition, str withName, str toPos)
    cpdef str getSurfaceForm(self)
    cpdef State getStartState(self)
    cpdef str getFinalPos(self)
    cpdef str getInitialPos(self)
    cpdef setForm(self, str name)
    cpdef State getFinalSuffix(self)
    cpdef str headerTransition(self)
    cpdef str pronounTransition(self)
    cpdef str transitionList(self)
    cpdef str suffixList(self)
    cpdef str withList(self)
    cpdef list getWithList(self)
