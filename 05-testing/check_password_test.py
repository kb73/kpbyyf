import pytest
import System
import json

def test_login(grading_system):
    username = 'calyam'
    password = 'TA'
    




@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    assert gradingSystem.users['calyam']['password'] == '#yeet'
    return gradingSystem