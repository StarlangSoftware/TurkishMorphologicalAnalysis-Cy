from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize(["MorphologicalAnalysis/*.pyx", "DisambiguationCorpus/*.pyx"],
                          compiler_directives={'language_level': "3"}),
    name='NlpToolkit-MorphologicalAnalysis-Cy',
    version='1.0.17',
    packages=['MorphologicalAnalysis', 'DisambiguationCorpus'],
    package_data={'MorphologicalAnalysis': ['*.pxd', '*.pyx', '*.c', '*.py'],
                  'DisambiguationCorpus': ['*.pxd', '*.pyx', '*.c', '*.py']},
    url='https://github.com/StarlangSoftware/TurkishMorphologicalAnalysis-Cy',
    license='',
    author='olcaytaner',
    author_email='olcay.yildiz@ozyegin.edu.tr',
    description='Turkish Morphological Analysis',
    install_requires=['NlpToolkit-Dictionary-Cy', 'NlpToolkit-Corpus-Cy', 'NlpToolkit-DataStructure-Cy']
)
