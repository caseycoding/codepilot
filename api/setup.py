import setuptools

setuptools.setup(
    name='Casey',
    entry_points={
        'console_scripts': [
            'api = server.server:main'
        ]
    },
    packages=setuptools.find_packages(),
)