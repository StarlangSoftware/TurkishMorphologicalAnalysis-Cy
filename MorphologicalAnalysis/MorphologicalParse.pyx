from Dictionary.Word cimport Word

from MorphologicalAnalysis.InflectionalGroup cimport InflectionalGroup
from MorphologicalAnalysis.MorphologicalTag import MorphologicalTag


cdef class MorphologicalParse:

    def __init__(self, parse=None):
        """
        Constructor of MorphologicalParse class which takes a String parse as an input. First it creates
        a list as iGs for inflectional groups, and while given String contains derivational boundary (^DB+), it
        adds the substring to the iGs list and continue to use given String from 4th index. If it does not contain ^DB+,
        it directly adds the given String to the iGs list. Then, it creates a new list as
        inflectionalGroups and checks for some cases.

        If the first item of iGs list is ++Punc, it creates a new root as +, and by calling
        InflectionalGroup method with Punc it initializes the IG list by parsing given input
        String IG by + and calling the getMorphologicalTag method with these substrings. If getMorphologicalTag method
        returns a tag, it adds this tag to the IG list and also to the inflectionalGroups list.

        If the first item of iGs list has +, it creates a new word of first item's substring from index 0 to +,
        and assigns it to root. Then, by calling InflectionalGroup method with substring from index 0 to +,
        it initializes the IG list by parsing given input String IG by + and calling the getMorphologicalTag
        method with these substrings. If getMorphologicalTag method returns a tag, it adds this tag to the IG list
        and also to the inflectionalGroups list.

        If the first item of iGs list does not contain +, it creates a new word with first item and assigns it as root.
        At the end, it loops through the items of iGs and by calling InflectionalGroup method with these items
        it initializes the IG list by parsing given input String IG by + and calling the getMorphologicalTag
        method with these substrings. If getMorphologicalTag method returns a tag, it adds this tag to the IG list
        and also to the inflectionalGroups list.

        PARAMETERS
        ----------
        parse : str
            String input.
        """
        cdef list iGs
        cdef str st
        cdef int i
        if parse is not None:
            if isinstance(parse, str):
                iGs = []
                st = parse
                while "^DB+" in st:
                    iGs.append(st[:st.index("^DB+")])
                    st = st[st.index("^DB+") + 4:]
                iGs.append(st)
                self.inflectionalGroups = []
                if iGs[0] == "++Punc":
                    self.root = Word("+")
                    self.inflectionalGroups.append(InflectionalGroup("Punc"))
                else:
                    if iGs[0].index("+") != -1:
                        self.root = Word(iGs[0][:iGs[0].index("+")])
                        self.inflectionalGroups.append(InflectionalGroup(iGs[0][iGs[0].index("+") + 1:]))
                    else:
                        self.root = Word(iGs[0])
                    for i in range(1, len(iGs)):
                        self.inflectionalGroups.append(InflectionalGroup(iGs[i]))
            elif isinstance(parse, list):
                self.inflectionalGroups = []
                if parse[0].index("+") != -1:
                    self.root = Word(parse[0][:parse[0].index("+")])
                    self.inflectionalGroups.append(InflectionalGroup(parse[0][parse[0].index("+") + 1:]))
                for i in range(1, len(parse)):
                    self.inflectionalGroups.append(InflectionalGroup(parse[i]))

    cpdef Word getWord(self):
        """
        The no-arg getWord method returns root Word.

        RETURNS
        -------
        Word
            root Word.
        """
        return self.root

    cpdef str getTransitionList(self):
        """
        The getTransitionList method gets the first item of inflectionalGroups list as a str, then loops
        through the items of inflectionalGroups and concatenates them by using +.

        RETURNS
        -------
        str
            String that contains transition list.
        """
        cdef str result
        cdef int i
        result = self.inflectionalGroups[0].__str__()
        for i in range(1, len(self.inflectionalGroups)):
            result = result + "+" + self.inflectionalGroups[i].__str__()
        return result

    cpdef str getInflectionalGroupString(self, int index):
        """
        The getInflectionalGroupString method takes an int index as an input and if index is 0, it directly returns the
        root and the first item of inflectionalGroups list. If the index is not 0, it then returns the corresponding
        item of inflectionalGroups list as a str.

        PARAMETERS
        ----------
        index : int
            Integer input.

        RETURNS
        -------
        str
            Corresponding item of inflectionalGroups at given index as a str.
        """
        if index == 0:
            return self.root.getName() + "+" + self.inflectionalGroups[0].__str__()
        else:
            return self.inflectionalGroups[index].__str__()

    cpdef InflectionalGroup getInflectionalGroup(self, int index):
        """
        The getInflectionalGroup method takes an integer index as an input and it directly returns the InflectionalGroup
        at given index.

        PARAMETERS
        ----------
        index : int
            Integer input.

        RETURNS
        -------
        InflectionalGroup
            InflectionalGroup at given index.
        """
        return self.inflectionalGroups[index]

    cpdef InflectionalGroup getLastInflectionalGroup(self):
        """
        The getLastInflectionalGroup method directly returns the last InflectionalGroup of inflectionalGroups list.

        RETURNS
        -------
        InflectionalGroup
            The last InflectionalGroup of inflectionalGroups list.
        """
        return self.inflectionalGroups[len(self.inflectionalGroups) - 1]

    cpdef str getTag(self, int index):
        """
        The getTag method takes an integer index as an input and and if the given index is 0, it directly return the
        root. Then, it loops through the inflectionalGroups list it returns the MorphologicalTag of the corresponding
        inflectional group.

        PARAMETERS
        ----------
        index : int
            Integer input.

        RETURNS
        -------
        str
            The MorphologicalTag of the corresponding inflectional group, or null of invalid index inputs.
        """
        cdef int size
        cdef InflectionalGroup group
        size = 1
        if index == 0:
            return self.root.getName()
        for group in self.inflectionalGroups:
            if index < size + group.size():
                return InflectionalGroup.getTagString(group.getTag(index - size))
            size += group.size()
        return None

    cpdef int tagSize(self):
        """
        The tagSize method loops through the inflectionalGroups list and accumulates the sizes of each inflectional
        group in the inflectionalGroups.

        RETURNS
        -------
        int
            Total size of the inflectionalGroups list.
        """
        cdef int size
        cdef InflectionalGroup group
        size = 1
        for group in self.inflectionalGroups:
            size += group.size()
        return size

    cpdef int size(self):
        """
        The size method returns the size of the inflectionalGroups list.

        RETURNS
        -------
        int
            The size of the inflectionalGroups list.
        """
        return len(self.inflectionalGroups)

    cpdef InflectionalGroup firstInflectionalGroup(self):
        """
        The firstInflectionalGroup method returns the first inflectional group of inflectionalGroups list.

        RETURNS
        -------
        InflectionalGroup
            The first inflectional group of inflectionalGroups list.
        """
        return self.inflectionalGroups[0]

    cpdef InflectionalGroup lastInflectionalGroup(self):
        """
        The lastInflectionalGroup method returns the last inflectional group of inflectionalGroups list.

        RETURNS
        -------
        InflectionalGroup
            The last inflectional group of inflectionalGroups list.
        """
        return self.inflectionalGroups[len(self.inflectionalGroups) - 1]

    cpdef Word getWordWithPos(self):
        """
        The getWordWithPos method returns root with the MorphologicalTag of the first inflectional as a new word.

        RETURNS
        -------
        Word
            Root with the MorphologicalTag of the first inflectional as a new word.
        """
        return Word(self.root.getName() + "+" + InflectionalGroup.getTagString(self.firstInflectionalGroup().getTag(0)))

    cpdef str getPos(self):
        """
        The getPos method returns the MorphologicalTag of the last inflectional group.

        RETURNS
        -------
        str
            The MorphologicalTag of the last inflectional group.
        """
        return InflectionalGroup.getTagString(self.lastInflectionalGroup().getTag(0))

    cpdef str getRootPos(self):
        """
        The getRootPos method returns the MorphologicalTag of the first inflectional group.

        RETURNS
        -------
        str
            The MorphologicalTag of the first inflectional group.
        """
        return InflectionalGroup.getTagString(self.firstInflectionalGroup().getTag(0))

    cpdef str lastIGContainsCase(self):
        """
        The lastIGContainsCase method returns the MorphologicalTag of last inflectional group if it is one of the
        NOMINATIVE, ACCUSATIVE, DATIVE, LOCATIVE or ABLATIVE cases, null otherwise.

        RETURNS
        -------
        str
            The MorphologicalTag of last inflectional group if it is one of the NOMINATIVE, ACCUSATIVE, DATIVE, LOCATIVE
            or ABLATIVE cases, null otherwise.
        """
        cdef object caseTag
        caseTag = self.lastInflectionalGroup().containsCase()
        if caseTag is not None:
            return InflectionalGroup.getTagString(caseTag)
        else:
            return "NULL"

    cpdef bint lastIGContainsTag(self, object tag):
        """
        The lastIGContainsTag method takes a MorphologicalTag as an input and returns true if the last inflectional
        group's MorphologicalTag matches with one of the tags in the IG list, false otherwise.

        PARAMETERS
        ----------
        tag : MorphologicalTag
            MorphologicalTag type input.

        RETURNS
        -------
        bool
            True if the last inflectional group's MorphologicalTag matches with one of the tags in the IG list, False
            otherwise.
        """
        return self.lastInflectionalGroup().containsTag(tag)

    cpdef bint lastIGContainsPossessive(self):
        """
        lastIGContainsPossessive method returns true if the last inflectional group contains one of the
        possessives: P1PL, P1SG, P2PL, P2SG, P3PL AND P3SG, false otherwise.

        RETURNS
        -------
        bool
            True if the last inflectional group contains one of the possessives: P1PL, P1SG, P2PL, P2SG, P3PL AND P3SG,
            false otherwise.
        """
        return self.lastInflectionalGroup().containsPossessive()

    cpdef bint isCapitalWord(self):
        """
        The isCapitalWord method returns True if the character at first index of root is an uppercase letter, False
        otherwise.

        RETURNS
        -------
        bool
            True if the character at first index of root is an uppercase letter, False otherwise.
        """
        return self.root.getName()[0:0].isupper()

    cpdef bint isNoun(self):
        """
        The isNoun method returns true if the past of speech is NOUN, False otherwise.

        RETURNS
        -------
        bool
            True if the past of speech is NOUN, False otherwise.
        """
        return self.getPos() == "NOUN"

    cpdef bint isVerb(self):
        """
        The isVerb method returns true if the past of speech is VERB, False otherwise.

        RETURNS
        -------
        bool
            True if the past of speech is VERB, False otherwise.
        """
        return self.getPos() == "VERB"

    cpdef bint isRootVerb(self):
        """
        The isRootVerb method returns True if the past of speech of root is BERV, False otherwise.

        RETURNS
        -------
        bool
            True if the past of speech of root is VERB, False otherwise.
        """
        return self.getRootPos() == "VERB"

    cpdef bint isAdjective(self):
        """
        The isAdjective method returns True if the past of speech is ADJ, False otherwise.

        RETURNS
        -------
        bool
            True if the past of speech is ADJ, False otherwise.
        """
        return self.getPos() == "ADJ"

    cpdef bint isProperNoun(self):
        """
        The isProperNoun method returns True if the first inflectional group's MorphologicalTag is a PROPERNOUN, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a PROPERNOUN, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.PROPERNOUN)

    cpdef bint isPunctuation(self):
        """
        The isPunctuation method returns True if the first inflectional group's MorphologicalTag is a PUNCTUATION, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a PUNCTUATION, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.PUNCTUATION)

    cpdef bint isCardinal(self):
        """
        The isCardinal method returns True if the first inflectional group's MorphologicalTag is a CARDINAL, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a CARDINAL, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.CARDINAL)

    cpdef bint isOrdinal(self):
        """
        The isOrdinal method returns True if the first inflectional group's MorphologicalTag is a ORDINAL, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a ORDINAL, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.ORDINAL)

    cpdef bint isReal(self):
        """
        The isReal method returns True if the first inflectional group's MorphologicalTag is a REAL, False otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a REAL, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.REAL)

    cpdef bint isNumber(self):
        """
        The isNumber method returns True if the first inflectional group's MorphologicalTag is REAL or CARDINAL, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a REAL or CARDINAL, False otherwise.
        """
        return self.isReal() or self.isCardinal()

    cpdef bint isTime(self):
        """
        The isTime method returns True if the first inflectional group's MorphologicalTag is a TIME, False otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a TIME, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.TIME)

    cpdef bint isDate(self):
        """
        The isDate method returns True if the first inflectional group's MorphologicalTag is a DATE, False otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a DATE, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.DATE)

    cpdef bint isHashTag(self):
        """
        The isHashTag method returns True if the first inflectional group's MorphologicalTag is a HASHTAG, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a HASHTAG, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.HASHTAG)

    cpdef bint isEmail(self):
        """
        The isEmail method returns True if the first inflectional group's MorphologicalTag is a EMAIL, False otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a EMAIL, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.EMAIL)

    cpdef bint isPercent(self):
        """
        The isPercent method returns True if the first inflectional group's MorphologicalTag is a PERCENT, False
        otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a PERCENT, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.PERCENT)

    cpdef bint isFraction(self):
        """
         The isFraction method returns True if the first inflectional group's MorphologicalTag is a FRACTION, False
         otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a FRACTION, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.FRACTION)

    cpdef bint isRange(self):
        """
        The isRange method returns True if the first inflectional group's MorphologicalTag is a RANGE, False otherwise.

        RETURNS
        -------
        bool
            True if the first inflectional group's MorphologicalTag is a RANGE, False otherwise.
        """
        return self.getInflectionalGroup(0).containsTag(MorphologicalTag.RANGE)

    cpdef bint isPlural(self):
        """
        The isPlural method returns true if InflectionalGroup's MorphologicalTags are from the agreement plural
        or possessive plural, i.e A1PL, A2PL, A3PL, P1PL, P2PL or P3PL, and False otherwise.

        RETURNS
        -------
        bool
            True if InflectionalGroup's MorphologicalTags are from the agreement plural or possessive plural.
        """
        cdef InflectionalGroup inflectionalGroup
        for inflectionalGroup in self.inflectionalGroups:
            if inflectionalGroup.containsPlural():
                return True
        return False

    cpdef bint isAuxiliary(self):
        """
        The isAuxiliary method returns true if the root equals to the et, ol, or yap, and false otherwise.

        RETURNS
        -------
        bool
            True if the root equals to the et, ol, or yap, and False otherwise.
        """
        return self.root.getName() == "et" or self.root.getName() == "ol" or self.root.getName() == "yap"

    cpdef bint containsTag(self, object tag):
        """
        The containsTag method takes a MorphologicalTag as an input and loops through the inflectionalGroups list,
        returns True if the input matches with on of the tags in the IG, False otherwise.

        PARAMETERS
        ----------
        tag : MorphologicalTag
            checked tag

        RETURNS
        -------
        bool
            True if the input matches with on of the tags in the IG, False otherwise.
        """
        cdef InflectionalGroup inflectionalGroup
        for inflectionalGroup in self.inflectionalGroups:
            if inflectionalGroup.containsTag(tag):
                return True
        return False

    cpdef str getTreePos(self):
        """
        The getTreePos method returns the tree pos tag of a morphological analysis.

        RETURNS
        -------
        bool
            Tree pos tag of the morphological analysis in string form.
        """
        if self.isProperNoun():
            return "NP"
        elif self.root.getName() == "değil":
            return "NEG"
        elif self.isVerb():
            if self.lastIGContainsTag(MorphologicalTag.ZERO):
                return "NOMP"
            else:
                return "VP"
        elif self.isAdjective():
            return "ADJP"
        elif self.isNoun() or self.isPercent():
            return "NP"
        elif self.containsTag(MorphologicalTag.ADVERB):
            return "ADVP"
        elif self.isNumber() or self.isFraction():
            return "NUM"
        elif self.containsTag(MorphologicalTag.POSTPOSITION):
            return "PP"
        elif self.containsTag(MorphologicalTag.CONJUNCTION):
            return "CONJP"
        elif self.containsTag(MorphologicalTag.DETERMINER):
            return "DP"
        elif self.containsTag(MorphologicalTag.INTERJECTION):
            return "INTJP"
        elif self.containsTag(MorphologicalTag.QUESTIONPRONOUN):
            return "WP"
        elif self.containsTag(MorphologicalTag.PRONOUN):
            return "NP"
        elif self.isPunctuation():
            if self.root.getName() == "!" or self.root.getName() == "?":
                return "."
            elif self.root.getName() == ";" or self.root.getName() == "-" or self.root.getName() == "--":
                return ":"
            elif self.root.getName() == "(" or self.root.getName() == "-LRB-" or self.root.getName() == "-lrb-":
                return "-LRB-"
            elif self.root.getName() == ")" or self.root.getName() == "-RRB-" or self.root.getName() == "-rrb-":
                return "-RRB-"
            else:
                return self.root.getName()
        else:
            return "-XXX-"

    def __str__(self):
        """
        The overridden toString method gets the root and the first inflectional group as a result String then
        concatenates with ^DB+ and the following inflectional groups.

        RETURNS
        -------
        str
            result str.
        """
        cdef str result
        cdef int i
        result = self.root.getName() + "+" + self.inflectionalGroups[0].__str__()
        for i in range(1, len(self.inflectionalGroups)):
            result = result + "^DB+" + self.inflectionalGroups[i].__str__()
        return result
