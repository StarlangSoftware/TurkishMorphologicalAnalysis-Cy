cdef class DisambiguatedWord(Word):

    def __init__(self,
                 name: str,
                 parse: MorphologicalParse):
        """
        The constructor of {@link DisambiguatedWord} class which takes a str and a MorphologicalParse
        as inputs. It creates a new MorphologicalParse with given MorphologicalParse. It generates a new instance with
        given str.
         *
         * @param name  Instances that will be a DisambiguatedWord.
         * @param parse {@link MorphologicalParse} of the {@link DisambiguatedWord}.
        """
        super().__init__(name)
        self.__parse = parse

    cpdef MorphologicalParse getParse(self):
        """
        Accessor for the MorphologicalParse.

        RETURNS
        -------
        MorphologicalParse
            MorphologicalParse.
        """
        return self.__parse

    def __repr__(self):
        return f"{self.name} {self.__parse}"
