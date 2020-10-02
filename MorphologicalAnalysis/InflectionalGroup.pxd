cdef class InflectionalGroup:

    cdef list __IG

    cpdef object getTag(self, int index)
    cpdef int size(self)
    cpdef object containsCase(self)
    cpdef bint containsPlural(self)
    cpdef bint containsTag(self, object tag)
    cpdef bint containsPossessive(self)
