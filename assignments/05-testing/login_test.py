import pytest
import System

#Tests if the program can create users
def test_login(grading_system):
    username = 'thtrhg'
    password =  'fhjhjdhjdfh'
    grading_system.login(username,password)


@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem