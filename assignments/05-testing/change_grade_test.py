import pytest
import json
import System
import Staff



def test_change_grade(grading_system):
    grading_system.login('cmhbf5', 'bestTA')
    grading_system.usr.change_grade('hdjsr7', 'cloud_computing', 'assignment1', 50)
    with open('Data/users.json') as f:
        usersJSON = json.load(f)

    assert usersJSON['hdjsr7']['courses']['cloud_computing']['assignment1']['grade'] == 40

@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem
