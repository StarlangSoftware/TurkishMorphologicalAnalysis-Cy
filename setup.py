from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize(["MorphologicalAnalysis/*.pyx"],
                          compiler_directives={'language_level': "3"}),
    name='NlpToolkit-MorphologicalAnalysis-Cy',
    version='1.0.3',
    packages=['MorphologicalAnalysis'],
    package_data={'MorphologicalAnalysis': ['*.pxd', '*.pyx', '*.c', '*.py']},
    url='https://github.com/olcaytaner/TurkishMorphologicalAnalysis-Cy',
    license='',
    author='olcaytaner',
    author_email='olcaytaner@isikun.edu.tr',
    description='Turkish Morphological Analysis',
    install_requires=['NlpToolkit-Dictionary-Cy', 'NlpToolkit-Corpus-Cy', 'NlpToolkit-DataStructure-Cy']
)
