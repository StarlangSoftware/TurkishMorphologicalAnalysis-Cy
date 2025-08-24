from setuptools import setup

from pathlib import Path
this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text(encoding="utf-8")
from Cython.Build import cythonize

setup(
    ext_modules=cythonize(["MorphologicalAnalysis/*.pyx", "DisambiguationCorpus/*.pyx"],
                          compiler_directives={'language_level': "3"}),
    name='nlptoolkit-morphologicalanalysis-cy',
    version='1.0.34',
    packages=['MorphologicalAnalysis', 'MorphologicalAnalysis.data', 'DisambiguationCorpus'],
    package_data={'MorphologicalAnalysis': ['*.pxd', '*.pyx', '*.c', '*.py'],
                  'DisambiguationCorpus': ['*.pxd', '*.pyx', '*.c', '*.py'],
                  'MorphologicalAnalysis.data': ['*.xml', '*.txt']},
    url='https://github.com/StarlangSoftware/TurkishMorphologicalAnalysis-Cy',
    license='',
    author='olcaytaner',
    author_email='olcay.yildiz@ozyegin.edu.tr',
    description='Turkish Morphological Analysis',
    install_requires=['NlpToolkit-Corpus-Cy'],
    long_description=long_description,
    long_description_content_type='text/markdown'
)
