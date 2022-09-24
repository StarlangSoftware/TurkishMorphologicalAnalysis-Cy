cdef class State:

    def __init__(self,
                 name: str,
                 startState: bool,
                 endState: bool,
                 pos=None):
        """
        Second constructor of the State class which takes 4 parameters as input; String name, boolean startState,
        boolean endState, and String pos and initializes the private variables of the class.

        PARAMETERS
        ----------
        name : str
            String input.
        startState : bool
            boolean input.
        endState : bool
            boolean input.
        pos : str
            String input.
        """
        self.__end_state = endState
        self.__start_state = startState
        self.__name = name
        self.__pos = pos

    def __str__(self) -> str:
        """
        Overridden __str__ method which returns the name.

        RETURNS
        -------
        str
            String name.
        """
        return self.__name

    cpdef str getName(self):
        """
        Getter for the name.

        RETURNS
        -------
        str
            String name.
        """
        return self.__name

    cpdef str getPos(self):
        """
        Getter for the pos.

        RETURNS
        -------
        str
            String pos.
        """
        return self.__pos

    cpdef bint isEndState(self):
        """
        The isEndState method returns endState's value.

        RETURNS
        -------
        bool
            boolean endState.
        """
        return self.__end_state
