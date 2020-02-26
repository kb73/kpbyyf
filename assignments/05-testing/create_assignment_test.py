import pytest
import json
import Staff
import System

def test_create_assignment(grading_system):

    grading_system.login('cmhbf5', 'bestTA')
    grading_system.usr.create_assignment('mA', '2/22/2222', 'comp_sci')
    course_made = False
    assignments = grading_system.courses['comp_sci']['assignments']
    for key in assignments:
        print(key)
        if key == 'mA':
            course_made = True
    assert course_made == True

@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem

