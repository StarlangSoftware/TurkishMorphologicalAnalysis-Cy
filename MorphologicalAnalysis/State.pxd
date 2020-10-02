cdef class State:

    cdef bint __startState, __endState
    cdef str __name, __pos

    cpdef str getName(self)
    cpdef str getPos(self)
    cpdef bint isEndState(self)
