from setuptools import setup
import versioneer

requirements = [
    # package requirements go here
]

setup(
    name='realtime-segmentation-engine',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description="The Real-time Segmentation Engine (RSE) is an in-memory columnar store optimized for fast segmentation queries as well as queries for fast changing member attributes.",
    author="Kenneth Mandawe",
    author_email='kdmandawe06@gmail.com',
    url='https://github.com/kmandawe/realtime-segmentation-engine',
    packages=['cpt'],
    entry_points={
        'console_scripts': [
            'cpt=cpt.cli:cli'
        ]
    },
    install_requires=requirements,
    keywords='realtime-segmentation-engine',
    classifiers=[
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
    ]
)
