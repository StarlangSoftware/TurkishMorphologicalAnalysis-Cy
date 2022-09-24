cdef class State:

    cdef bint __start_state, __end_state
    cdef str __name, __pos

    cpdef str getName(self)
    cpdef str getPos(self)
    cpdef bint isEndState(self)
