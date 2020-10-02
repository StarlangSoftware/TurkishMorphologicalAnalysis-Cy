from MorphologicalAnalysis.State cimport State


cdef class FiniteStateMachine:

    cdef list __states
    cdef dict __transitions

    cpdef bint isValidTransition(self, str transition)
    cpdef list getStates(self)
    cpdef State getState(self, str name)
    cpdef addTransition(self, State fromState, State toState, str _with, str withName, toPos=*)
    cpdef list getTransitions(self, State state)