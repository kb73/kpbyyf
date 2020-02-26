import pytest
import System
import json

def test_add_student(grading_system):
    grading_system.login('akend3', '123454321')
    grading_system.usr.submit_assignment('databases','assignment1', 'Hello World', '2/26/20')
    test = False
    student = grading_system.users['akend3']
    course = 'databases'
    assignment = 'assignment1'
    if student['courses'][course][assignment]["submission"] == 'Hello World' and student['courses'][course][assignment]['submission_date'] == '2/26/20':
        test = True
    assert test

@pytest.fixture
def grading_system():
    gradingSystem = System.System()
    gradingSystem.load_data()
    return gradingSystem