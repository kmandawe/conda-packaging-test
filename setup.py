from setuptools import setup
import versioneer

requirements = [
    # package requirements go here
]

setup(
    name='conda-packaging-test',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description="CPT is a conda packaging POC",
    license="MIT",
    author="Kenneth Mandawe",
    author_email='kdmandawe06@gmail.com',
    url='https://github.com/kmandawe/conda-packaging-test',
    packages=['cpt'],
    entry_points={
        'console_scripts': [
            'cpt=cpt.cli:cli'
        ]
    },
    install_requires=requirements,
    keywords='conda-packaging-test',
    classifiers=[
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
    ]
)
